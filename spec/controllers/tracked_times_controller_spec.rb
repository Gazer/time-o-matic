require 'spec_helper'

describe TrackedTimesController do

  describe "GET 'index'" do
    it "returns http success" do
      get 'index', format: :json

      expect(response).to be_success
    end
  end

  describe "DELETE" do
    it "remove a tracked time from the database" do
      time = TrackedTime.create name: 'Some Tracked Time'

      expect {
        delete 'destroy', id: time.id, format: :json
        ActiveRecord::Base.connection.query_cache.clear
      }.to change { TrackedTime.count() }.from(1).to(0)
    end
  end
end
