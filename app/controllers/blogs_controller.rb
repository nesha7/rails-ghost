class BlogsController < ApplicationController
	before_action :resolve_app
	before_action :set_settings

	def index
		@posts = ghost_client.get_posts(params[:page] || 1)

		render layout: "#{@app}/layouts/blog"
	end

	def show
		@post = ghost_client.get_post(request.path)

		render layout: "#{@app}/layouts/blog"
	end
end
