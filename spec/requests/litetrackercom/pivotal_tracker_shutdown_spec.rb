require 'rails_helper'

RSpec.describe "Litetrackercom::PivotalTrackerShutdown", type: :request do
  before do
    host! "litetracker.com"
  end

  describe "GET /pivotal-tracker-shutdown" do
    it "returns http success" do
      get "/pivotal-tracker-shutdown"

      expect(response).to have_http_status(:success)
    end

    it "renders the pivotal tracker shutdown page" do
      get "/pivotal-tracker-shutdown"

      expect(response.body).to include("Pivotal Tracker Is Gone")
      expect(response.body).to include("LiteTracker")
    end

    it "contains shutdown-focused messaging" do
      get "/pivotal-tracker-shutdown"

      expect(response.body).to include("Pivotal Tracker Has Shut Down")
      expect(response.body).to include("Don't Lose Years of Work")
    end

    it "contains what gets preserved section" do
      get "/pivotal-tracker-shutdown"

      expect(response.body).to include("What Gets Preserved")
      expect(response.body).to include("Save Everything You've Built")
    end

    it "contains same workflow section" do
      get "/pivotal-tracker-shutdown"

      expect(response.body).to include("Same Workflow")
      expect(response.body).to include("Keep Working the Way You Know")
    end

    it "contains shutdown FAQ section" do
      get "/pivotal-tracker-shutdown"

      expect(response.body).to include("Shutdown FAQ")
      expect(response.body).to include("When did Pivotal Tracker shut down?")
    end
  end
end
