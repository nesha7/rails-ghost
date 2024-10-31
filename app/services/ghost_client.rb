class GhostClient
  HOST_URL = ENV['GHOST_API_URL']
  CONTENT_API_KEY = ENV['GHOST_CONTENT_API_KEY']

  def get_post(slug)
    begin
      resp = HTTParty.get(
        "#{HOST_URL}/content/posts/slug#{slug}?key=#{CONTENT_API_KEY}&include=authors,tags"
      )

      JSON.parse(resp.body)['posts'].first
    rescue => e
      Rails.logger.error e.message
    end
  end

  def get_posts
    begin
      resp = HTTParty.get(
        "#{HOST_URL}/content/posts/?key=#{CONTENT_API_KEY}&include=authors,tags"
      )

      JSON.parse(resp.body)['posts']
    rescue => e
      Rails.logger.error e.message
    end
  end
end
