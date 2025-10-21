namespace :sitemap do
  desc "Generate all sitemaps"
  task :generate_all => :environment do
    Dir[Rails.root.join('config/sitemaps/*.rb')].each do |file|
      puts "Generating sitemap for #{File.basename(file, '.rb')}"
      load file
    end
  end

  desc "Generate sitemap for a single site. For example: rake sitemap:generate[litetracker]"
  task :generate, [:site] => :environment do |t, args|
    file = Rails.root.join("config/sitemaps/#{args[:site]}.rb")
    if File.exist?(file)
      puts "Generating sitemap for #{args[:site]}"
      load file
    else
      puts "Sitemap config not found for site: #{args[:site]}"
    end
  end
end
