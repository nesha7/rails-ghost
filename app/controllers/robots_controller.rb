class RobotsController < ApplicationController
  def show
    sitemap_folder = app_name.gsub(".", "")
    path = Rails.root.join('public', 'sitemaps', sitemap_folder)

    content = if Dir.exist?(path)
                <<~ROBOTS
                  User-agent: *
                  Allow:

                  Sitemap: https://#{request.host}/sitemap.xml.gz
                ROBOTS
              else
                "User-agent: *\Allow: /"
              end

    render plain: content, content_type: 'text/plain'
  end
end
