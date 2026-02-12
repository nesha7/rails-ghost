require 'rails_helper'

RSpec.describe "Kolosekaicom::Sitemap", type: :request do
  before do
    host! "kolosek.com"
  end

  describe "GET /sitemap.xml" do
    context "when sitemap has been generated" do
      before do
        dir = Rails.root.join('public', 'sitemaps', 'kolosekcom')
        FileUtils.mkdir_p(dir)

        xml_content = <<~XML
          <?xml version="1.0" encoding="UTF-8"?>
          <urlset xmlns="http://www.sitemaps.org/schemas/sitemap/0.9">
            <url><loc>https://kolosek.com/</loc></url>
            <url><loc>https://kolosek.com/about</loc></url>
            <url><loc>https://kolosek.com/featured</loc></url>
            <url><loc>https://kolosek.com/pricing</loc></url>
            <url><loc>https://kolosek.com/contact</loc></url>
          </urlset>
        XML

        Zlib::GzipWriter.open(dir.join('sitemap.xml.gz').to_s) do |gz|
          gz.write(xml_content)
        end
      end

      after do
        FileUtils.rm_rf(Rails.root.join('public', 'sitemaps', 'kolosekcom'))
      end

      it "returns http success" do
        get "/sitemap.xml"

        expect(response).to have_http_status(:success)
      end

      it "returns XML content type" do
        get "/sitemap.xml"

        expect(response.content_type).to include("xml")
      end

      it "includes all kolosekcom page URLs" do
        get "/sitemap.xml"

        expect(response.body).to include("https://kolosek.com/")
        expect(response.body).to include("https://kolosek.com/about")
        expect(response.body).to include("https://kolosek.com/featured")
        expect(response.body).to include("https://kolosek.com/pricing")
        expect(response.body).to include("https://kolosek.com/contact")
      end
    end

    context "when sitemap has not been generated" do
      before do
        FileUtils.rm_rf(Rails.root.join('public', 'sitemaps', 'kolosekcom'))
      end

      it "returns not found" do
        get "/sitemap.xml"

        expect(response).to have_http_status(:not_found)
      end
    end
  end
end
