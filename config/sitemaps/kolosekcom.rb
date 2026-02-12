SitemapGenerator::Sitemap.default_host = "https://kolosek.com"
SitemapGenerator::Sitemap.public_path = 'public/sitemaps/kolosekcom/'
SitemapGenerator::Sitemap.create do
  add '/', changefreq: 'monthly', priority: 0.9
  add '/about', changefreq: 'monthly', priority: 0.8
  add '/featured', changefreq: 'monthly', priority: 0.8
  add '/pricing', changefreq: 'monthly', priority: 0.8
  add '/contact', changefreq: 'monthly', priority: 0.8
end
