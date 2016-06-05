class TrackedTime < ActiveRecord::Base
  scope :today, -> { where('end_at IS NOT NULL AND created_at >= ?', Time.now.beginning_of_day).order('created_at desc') }
  scope :active, -> { where('end_at IS NULL') }

  validate :active_track

  def self.current
    self.active.first
  end

  def stop!
    self.end_at = Time.now
    save!
  end

  def running?
    !end_at
  end

  def duration
    if running?
      (Time.now - created_at).to_i
    else
      (end_at - created_at).to_i
    end
  end

  def copy!
    TrackedTime.create! name: name
  rescue
    nil
  end

private
  def active_track
    errors.add(:base, "you have a track already running") if TrackedTime.where("id != ?", id || 0).active.any?
  end
end
