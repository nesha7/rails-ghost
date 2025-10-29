class BlogsController < ApplicationController
	layout :resolve_layout
	before_action :set_settings

	def index
		@posts = ghost_client.get_data(:posts, page: params[:page] || 1)
	end

	def show
		@post = ghost_client.get_data(:post, path: request.path)

		if blog_post_override_exists?
			render "#{app_name}/blogs/show"
		end
	end

	private

	def resolve_layout
		layout_exists?(:blog) ? "#{app_name}/layouts/blog" : "#{app_name}/layouts/application"
	end
	
	def blog_post_override_exists?
	  lookup_context.template_exists?("#{app_name}/blogs/show", [], false)
	end

end
