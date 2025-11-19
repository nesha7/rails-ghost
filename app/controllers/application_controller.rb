class ApplicationController < ActionController::Base
  before_action :load_scripts
  before_action :store_utm_in_session
  before_action :set_settings

  helper_method :app_name

  rescue_from ActiveRecord::RecordNotFound, with: :not_found
  rescue_from StandardError, with: :not_found unless Rails.env.development?

  def app_name
    @app ||= (Site::Config.site.app_domain || request.host).gsub(".", "")
  end

  def ghost_client
    @ghost_client ||= Ghost::Client.new
  end

  def set_settings
    @settings = begin
      Rails.cache.fetch("ghost_settings_#{app_name}", expires_in: 1.hour) do
        ghost_client.get_data(:settings)
      end
    rescue
      {}
    end

    @settings = {} unless @settings.is_a?(Hash)
    @settings['lang'] ||= 'en'
  end

	def not_found
    render file: Rails.public_path.join('404.html'), status: :not_found
  end

  protected

  def page_exists?(file_path)
	  lookup_context.template_exists?("#{app_name}/pages#{file_path}", [], false)
	end

  def layout_exists?(file_name)
	  lookup_context.template_exists?("#{app_name}/layouts/#{file_name}", [], false)
	end

  private

  def load_scripts
    begin
      @header_script = Script.find_by(key: 'header')&.value
      @footer_script = Script.find_by(key: 'footer')&.value
    rescue StandardError => e
      Rails.logger.error "load_scripts error: #{e.class} #{e.message}"
      @header_script = nil
      @footer_script = nil
    end
  end

  def store_utm_in_session
    %i[utm_source utm_medium utm_term utm_content utm_campaign].each do |key|
      session[key] = params[key] if params[key].present?
    end
  end
end
