class ApplicationController < ActionController::Base
  before_action :load_scripts

  def resolve_app
    @app = if request.host == 'kolosek.com'
             'kolosek'
           elsif request.host == 'fast.ci'
             'fastci'
           elsif request.host == 'litetracker.com'
             'litetracker'
           elsif request.host == 'demo.litetracker.com'
             'litetracker'
           else
             'rubyci'
           end
  end

  def ghost_client
    @ghost_client ||= GhostClient.new
  end

  def set_settings
    begin
      @settings = Rails.cache.fetch("ghost_settings_#{@app}", expires_in: 1.hour) do
        ghost_client.settings
      end
    rescue
      @settings = {}
    end
  end

	def route_not_found
    render file: Rails.public_path.join('404.html'), status: :not_found
  end

  private

  def load_scripts
    @header_script = Script.find_by(key: 'header')&.value
    @footer_script = Script.find_by(key: 'footer')&.value
  end
end
