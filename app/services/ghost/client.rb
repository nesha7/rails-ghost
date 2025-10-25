module Ghost
  class Client

    def get_data(page_type, params = {})
      begin
        data =  Ghost::Request.call(page_type, params)
        h_data = Ghost::Parser.new.parse(page_type, data)
        h_data
      rescue Ghost::Parser::ParseError => e
        Rails.logger.error "#{e.class}:" + e.message
        nil
      rescue Ghost::Request::RequestError => e
        Rails.logger.error "#{e.class}:" + e.message
        nil
      rescue => e
        Rails.logger.error "#{e.class}:" + e.message
        nil
      end
    end
  end
end