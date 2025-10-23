SitemapGenerator::Sitemap.default_host = "https://litetracker.com"
SitemapGenerator::Sitemap.create(filename: :sitemap_litetracker) do
  # --- Static pages ---
  add '/', changefreq: 'monthly', priority: 0.9
  add '/pricing', changefreq: 'monthly', priority: 0.8
  add '/about', changefreq: 'monthly', priority: 0.8
  add '/integrations', changefreq: 'monthly', priority: 0.8
  add '/onboard', changefreq: 'monthly', priority: 0.8
  add '/nesha', changefreq: 'monthly', priority: 0.8

  # --- Ghost blog posts ---
  ghost_client = GhostClient.new
  page = 1

  loop do
    posts = ghost_client.get_posts(page)
    break if posts.blank?

    posts.each do |post|
      add "/blog/#{post['slug']}", 
          lastmod: post['updated_at'] || post['published_at'], 
          changefreq: 'monthly', 
          priority: 0.6
    end

    page += 1
  end

  # --- Ghost pages ---
  page = 1
  loop do
    pages = ghost_client.get_pages(page)
    break if pages.blank?

    pages.each do |ghost_page|
      add "/#{ghost_page['slug']}",
          lastmod: ghost_page['updated_at'] || ghost_page['published_at'],
          changefreq: 'monthly',
          priority: 0.7
    end

    page += 1
  end
end