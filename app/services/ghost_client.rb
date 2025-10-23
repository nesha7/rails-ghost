class GhostClient
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

  def get_page(slug)
    begin
      resp = HTTParty.get(
        "#{host_url}/content/pages/slug#{slug}?key=#{api_key}"
      )

      JSON.parse(resp.body)['pages']&.first
    rescue => e
      Rails.logger.error e.message
      nil
    end
  end


  def get_post(path)
    begin
      resp = HTTParty.get(
        "#{host_url}/content/posts/slug/#{path.sub(/^\/blog\//, '')}?key=#{api_key}&include=authors,tags"
      )

      JSON.parse(resp.body)['posts'].first
    rescue => e
      Rails.logger.error e.message
      nil
    end
  end

  def get_posts(page)
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
    ENV['GHOST_API_URL']
  end

  def api_key
    ENV['GHOST_CONTENT_API_KEY']
  end
end
