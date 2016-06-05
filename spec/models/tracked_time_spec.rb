require 'spec_helper'

describe TrackedTime do
  it 'only have one active instance' do
    TrackedTime.create name: 'Example'

    expect {
      TrackedTime.create! name: 'Other'
    }.to raise_error(ActiveRecord::RecordInvalid)
  end

  it 'can be stopped' do
    time = TrackedTime.create name: 'Example'

    expect {
      time.stop!
    }.to change { time.reload.end_at }
  end

  it 'can be query for today finished tasks' do
    time1 = TrackedTime.create name: 'Old', created_at: 2.days.ago, end_at: Time.now
    time2 = TrackedTime.create name: 'From today', created_at: Time.now, end_at: 2.seconds.from_now

    expect(TrackedTime.today.count).to eq(1)
    expect(TrackedTime.today).to include(time2)
    expect(TrackedTime.today).not_to include(time1)
  end

  context 'copying' do
    let(:time) { TrackedTime.create name: 'Some Tracked Time', end_at: 1.second.from_now }

    before(:each) { @copy = time.copy! }

    it 'copy the name' do
      expect(@copy.name).to eq(time.name)
    end

    it 'creates a copy' do
      expect(@copy.id).to_not eq(time.id)
    end

    it 'creates a running track' do
      expect(@copy).to be_running
    end

    it "can't copy if there is another active track" do
      expect(@copy.copy!).to eq(nil)
    end
  end
end
