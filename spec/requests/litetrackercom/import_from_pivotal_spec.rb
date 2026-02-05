require 'rails_helper'

RSpec.describe "Litetrackercom::ImportFromPivotal", type: :request do
  before do
    host! "litetracker.com"
  end

  describe "GET /import-from-pivotal" do
    it "returns http success" do
      get "/import-from-pivotal"

      expect(response).to have_http_status(:success)
    end

    it "renders the import from pivotal page" do
      get "/import-from-pivotal"

      expect(response.body).to include("Import from Pivotal Tracker")
      expect(response.body).to include("LiteTracker")
    end

    it "contains how it works section" do
      get "/import-from-pivotal"

      expect(response.body).to include("How It Works")
      expect(response.body).to include("Three Simple Steps")
    end

    it "contains what gets imported section" do
      get "/import-from-pivotal"

      expect(response.body).to include("Everything Gets Imported")
      expect(response.body).to include("Stories")
      expect(response.body).to include("Epics")
      expect(response.body).to include("Labels")
    end

    it "contains import methods section" do
      get "/import-from-pivotal"

      expect(response.body).to include("Two Ways to Import")
      expect(response.body).to include("API Import")
      expect(response.body).to include("CSV Import")
    end

    it "contains import FAQ section" do
      get "/import-from-pivotal"

      expect(response.body).to include("Import FAQ")
      expect(response.body).to include("Where do I find my Pivotal Tracker API token?")
    end
  end
end
