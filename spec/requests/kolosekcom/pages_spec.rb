require 'rails_helper'

RSpec.describe "Kolosekaicom::Pages", type: :request do
  before do
    host! "kolosek.com"
  end

  describe "GET / (home)" do
    it "returns http success" do
      get "/"

      expect(response).to have_http_status(:success)
    end

    it "renders the hero section" do
      get "/"

      expect(response.body).to include("We build AI-powered products.")
      expect(response.body).to include("lr-hero")
    end

    it "contains bento cards with service offerings" do
      get "/"

      expect(response.body).to include("Custom AI Agents")
      expect(response.body).to include("LLM Integration")
      expect(response.body).to include("Rapid Prototyping")
      expect(response.body).to include("Workflow Automation")
      expect(response.body).to include("Full-Stack Development")
    end

    it "contains pricing cards" do
      get "/"

      expect(response.body).to include("Project-Based")
      expect(response.body).to include("Time & Materials")
      expect(response.body).to include("Dedicated Team")
      expect(response.body).to include("Most Popular")
    end

    it "contains metric cards" do
      get "/"

      expect(response.body).to include("3x faster delivery")
      expect(response.body).to include("50+ AI projects shipped")
    end

    it "contains FAQ section" do
      get "/"

      expect(response.body).to include("What kind of AI projects do you build?")
      expect(response.body).to include("How do we get started?")
    end

    it "renders the layout with navigation and footer" do
      get "/"

      expect(response.body).to include("Kolosek AI - Native AI Agency")
      expect(response.body).to include("kolosekcom.css")
    end
  end

  describe "GET /about" do
    it "returns http success" do
      get "/about"

      expect(response).to have_http_status(:success)
    end

    it "renders the about hero" do
      get "/about"

      expect(response.body).to include("We are")
      expect(response.body).to include("Kolosek")
    end

    it "contains company stats" do
      get "/about"

      expect(response.body).to include("15+")
      expect(response.body).to include("Years of experience")
      expect(response.body).to include("200+")
      expect(response.body).to include("Projects shipped")
    end

    it "contains the company story timeline" do
      get "/about"

      expect(response.body).to include("2011")
      expect(response.body).to include("Founded as a Rails consultancy")
      expect(response.body).to include("2023")
      expect(response.body).to include("Pivoted to AI-native development")
    end

    it "contains team values" do
      get "/about"

      expect(response.body).to include("Deep AI Expertise")
      expect(response.body).to include("Full-Stack Builders")
      expect(response.body).to include("Direct Communication")
    end
  end

  describe "GET /featured" do
    it "returns http success" do
      get "/featured"

      expect(response).to have_http_status(:success)
    end

    it "renders the featured projects hero" do
      get "/featured"

      expect(response.body).to include("Featured")
      expect(response.body).to include("Projects")
    end

    it "contains own products" do
      get "/featured"

      expect(response.body).to include("LiteTracker")
      expect(response.body).to include("Ruby.ci")
    end

    it "contains client projects" do
      get "/featured"

      expect(response.body).to include("MoviePilot")
      expect(response.body).to include("Squire")
      expect(response.body).to include("Boardspan")
      expect(response.body).to include("WRAP")
      expect(response.body).to include("O.school")
      expect(response.body).to include("Simone LeBlanc")
    end
  end

  describe "GET /contact" do
    it "returns http success" do
      get "/contact"

      expect(response).to have_http_status(:success)
    end

    it "renders the contact hero" do
      get "/contact"

      expect(response.body).to include("intelligent together")
    end

    it "contains contact information" do
      get "/contact"

      expect(response.body).to include("Schedule a call")
      expect(response.body).to include("Email us")
      expect(response.body).to include("hello@kolosek.com")
    end

    it "contains the embedded contact form" do
      get "/contact"

      expect(response.body).to include("contact-form-uqybag")
    end
  end

  describe "GET /pricing" do
    it "returns http success" do
      get "/pricing"

      expect(response).to have_http_status(:success)
    end

    it "renders the pricing hero" do
      get "/pricing"

      expect(response.body).to include("Simple, transparent")
      expect(response.body).to include("pricing")
    end

    it "contains all three pricing tiers" do
      get "/pricing"

      expect(response.body).to include("Project-Based")
      expect(response.body).to include("Time & Materials")
      expect(response.body).to include("Dedicated Team")
    end

    it "contains comparison table" do
      get "/pricing"

      expect(response.body).to include("Compare")
      expect(response.body).to include("lr-compare-table")
      expect(response.body).to include("Core")
      expect(response.body).to include("Collaboration")
      expect(response.body).to include("Support")
    end

    it "contains pricing FAQ section" do
      get "/pricing"

      expect(response.body).to include("What's included in the pricing?")
      expect(response.body).to include("Do you offer hourly rates?")
    end
  end

end
