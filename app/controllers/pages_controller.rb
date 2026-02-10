class PagesController < ApplicationController
	layout :resolve_layout

	before_action :set_settings

	def index
		@posts = ghost_client.get_data(:posts, page: params[:page] || 1) || []
		@featured = @posts.select { |p| p['featured'] }.first(3)
		@hide_banner = true

		render "#{app_name}/pages/index", layout: "#{app_name}/layouts/application"
	end

	def show
		@hide_banner = true

		if page_exists?(request.path)
		  render "#{app_name}/pages#{request.path}"
		else
			@page = ghost_client.get_data(:page, slug: request.path)

			raise ActiveRecord::RecordNotFound, "Page not found" unless @page.present?
		end
	end

	private

	def resolve_layout
		if !page_exists?(request.path) && layout_exists?(:page)
			"#{app_name}/layouts/page"
		else
			"#{app_name}/layouts/application"
		end
	end
end
