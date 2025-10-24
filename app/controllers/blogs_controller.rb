class BlogsController < ApplicationController
	before_action :set_settings

	def index
		@posts = ghost_client.get_posts(params[:page] || 1)

		render layout: "#{@app}/layouts/blog"
	end

	def show
		@post = ghost_client.get_post(request.path)

		if @post.present?
			render layout: "#{@app}/layouts/blog"
		else
			redirect_to blog_path
		end
	end
end
