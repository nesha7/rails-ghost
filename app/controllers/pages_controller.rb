class PagesController < ApplicationController
	before_action :resolve_app
	before_action :set_settings

	def index
		render "#{@app}/pages/index", layout: "#{@app}/layouts/application"
	end

	def show
		if page_exists?(request.path)
		  render "#{@app}/pages#{request.path}", layout: "#{@app}/layouts/application"
		else
			@page = ghost_client.get_page(request.path)

			render layout: "#{@app}/layouts/blog"
		end
	end

	private

	def page_exists?(page_name)
	  lookup_context.template_exists?("#{@app}/pages#{page_name}", [], false)
	end
end
