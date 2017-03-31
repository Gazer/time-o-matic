class CreateTrackedTimes < ActiveRecord::Migration[5.0]
  def change
    create_table :tracked_times do |t|
      t.string :name
      t.timestamp :end_at, null: true

      t.timestamps null: false
    end
  end
end
