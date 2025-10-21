class GhostClient
  attr_reader :host

  def initialize(host)
    @host = host
  end

  def get_pages(page = 1)
    begin
      resp = HTTParty.get(
        "#{host_url}/content/pages?key=#{api_key}&page=#{page}"
      )

      JSON.parse(resp.body)['pages']
    rescue => e
      Rails.logger.error e.message
      []
    end
  end

  def get_post(slug)
    begin
      resp = HTTParty.get(
        "#{host_url}/content/posts/slug#{slug}?key=#{api_key}&include=authors,tags"
      )

      JSON.parse(resp.body)['posts'].first
    rescue => e
      Rails.logger.error e.message
      nil
    end
  end

  def get_posts(page = 1)
    begin
      resp = HTTParty.get(
        "#{host_url}/content/posts?key=#{api_key}&include=authors,tags&page=#{page}"
      )

      JSON.parse(resp.body)['posts']
    rescue => e
      Rails.logger.error e.message
    end
  end

  def settings
    begin
      resp = HTTParty.get(
        "#{host_url}/content/settings?key=#{api_key}"
      )

      JSON.parse(resp.body)['settings']
    rescue => e
      Rails.logger.error e.message
    end
  end

  private

  def host_url
    if host == 'kolosek.com'
      ENV['GHOST_API_URL_KOLOSEK']
    elsif host == 'fast.ci'
      ENV['GHOST_API_URL_FAST_CI']
    elsif host == 'litetracker.com'
      ENV['GHOST_API_URL_LITETRACKER']
    elsif host == 'demo.litetracker.com'
      ENV['GHOST_API_URL_LITETRACKER']
    else
      ENV['GHOST_API_URL']
    end
  end

  def api_key
    if host == 'kolosek.com'
      ENV['GHOST_CONTENT_API_KEY_KOLOSEK']
    elsif host == 'fast.ci'
      ENV['GHOST_CONTENT_API_KEY_FAST_CI']
    elsif host == 'litetracker.com'
      ENV['GHOST_CONTENT_API_KEY_LITETRACKER']
    elsif host == 'demo.litetracker.com'
      ENV['GHOST_CONTENT_API_KEY_LITETRACKER']
    else
      ENV['GHOST_CONTENT_API_KEY']
    end
  end
end
