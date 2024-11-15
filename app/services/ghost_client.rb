class GhostClient
  attr_reader :host

  def initialize(host)
    @host = host
  end

  def get_post(slug)
    begin
      resp = HTTParty.get(
        "#{host_url}/content/posts/slug#{slug}?key=#{api_key}&include=authors,tags"
      )

      JSON.parse(resp.body)['posts'].first
    rescue => e
      Rails.logger.error e.message
    end
  end

  def get_posts
    begin
      resp = HTTParty.get(
        "#{host_url}/content/posts?key=#{api_key}&include=authors,tags"
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
    else
      ENV['GHOST_API_URL']
    end
  end

  def api_key
    if host == 'kolosek.com'
      ENV['GHOST_CONTENT_API_KEY_KOLOSEK']
    elsif host == 'fast.ci'
      ENV['GHOST_CONTENT_API_KEY_FAST_CI']
    else
      ENV['GHOST_CONTENT_API_KEY']
    end
  end
end
