class PagesController < ApplicationController
	before_action :resolve_app
	before_action :set_settings

	def index
		render "#{@app}/pages/index", layout: "#{@app}/layouts/application"
	end

	def pricing
		render "#{@app}/pages/pricing", layout: "#{@app}/layouts/application"
	end

	def features
		render "#{@app}/pages/features", layout: "#{@app}/layouts/application"
	end

	def post
		@posts = Rails.cache.fetch("posts", expires_in: 1.hour) do
			ghost_client.get_posts.reverse
		end

		@post = request.path == '/docs' ? 
			@posts.select {|p| p['custom_template'] == 'custom-documentation'}.first : ghost_client.get_post(request.path)

		if @post['custom_template'] == 'custom-documentation'
			render "#{@app}/pages/post", layout: "#{@app}/layouts/docs"
		else
			render "#{@app}/pages/blog", layout: "#{@app}/layouts/blog"
		end
	end

	def blogs
		@posts  = Rails.cache.fetch("blogs", expires_in: 1.hour) do
			ghost_client.get_posts.select {|p| p['custom_template'] != 'custom-documentation'}
		end
		@fatured = @posts.select {|p| p['featured']}.first(3)

		render "#{@app}/pages/blogs", layout: "#{@app}/layouts/blog"
	end

	private

	def ghost_client
		@ghost_client ||= GhostClient.new(request.host)
	end

	def set_settings
		@settings = Rails.cache.fetch("ghost_settings", expires_in: 1.hour) do
			ghost_client.settings
		end
	end

	def resolve_app
		if request.host == 'fast.ci'
			@app = 'fastci'
			@host = 'fast.ci'
		else
			@app = 'rubyci'
			@host = 'ruby.ci'
		end
	end
end
