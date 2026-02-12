require 'rails_helper'

RSpec.describe "Kolosekaicom::Robots", type: :request do
  before do
    host! "kolosek.com"
  end

  describe "GET /robots.txt" do
    context "when sitemap directory exists" do
      before do
        FileUtils.mkdir_p(Rails.root.join('public', 'sitemaps', 'kolosekcom'))
      end

      after do
        FileUtils.rm_rf(Rails.root.join('public', 'sitemaps', 'kolosekcom'))
      end

      it "returns http success" do
        get "/robots.txt"

        expect(response).to have_http_status(:success)
      end

      it "returns plain text content type" do
        get "/robots.txt"

        expect(response.content_type).to include("text/plain")
      end

      it "includes sitemap URL for kolosek.com" do
        get "/robots.txt"

        expect(response.body).to include("Sitemap: https://kolosek.com/sitemap.xml.gz")
      end

      it "allows all user agents" do
        get "/robots.txt"

        expect(response.body).to include("User-agent: *")
        expect(response.body).to include("Allow:")
      end
    end

    context "when sitemap directory does not exist" do
      before do
        FileUtils.rm_rf(Rails.root.join('public', 'sitemaps', 'kolosekcom'))
      end

      it "returns a basic robots.txt" do
        get "/robots.txt"

        expect(response).to have_http_status(:success)
        expect(response.body).to include("User-agent: *")
      end
    end
  end
end
