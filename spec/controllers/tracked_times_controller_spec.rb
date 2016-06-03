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

      delete 'destroy', id: time.id, format: :json
      expect(TrackedTime.where(id: time.id)).to_not exist
    end
  end
end
