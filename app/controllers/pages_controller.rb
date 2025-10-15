class PagesController < ApplicationController
	before_action :resolve_app
	before_action :set_settings
	before_action :set_posts, only: :index

	def index
		render "#{@app}/pages/index", layout: "#{@app}/layouts/application"
	end

	def pricing
		render "#{@app}/pages/pricing", layout: "#{@app}/layouts/application"
	end

	def features
		render "#{@app}/pages/features", layout: "#{@app}/layouts/application"
	end

	def circle_ci
		render "#{@app}/pages/circle_ci", layout: "#{@app}/layouts/application"
	end

	def post
		if params[:path] == 'hcpm'
			head :ok and return
		end

		@posts = Rails.cache.fetch("posts_#{@app}", expires_in: 1.hour) do
			ghost_client.get_posts.reverse
		end

		posts = ghost_client.get_posts
		@posts = posts.is_a?(Array) ? posts.reverse : []

		@post = request.path == '/docs' ? 
			@posts.select {|p| p['custom_template'] == 'custom-documentation'}.first : ghost_client.get_post(request.path)

		unless @post.is_a?(Hash)
			Rails.logger.error("Invalid @post value for path=#{request.path}: #{@post.inspect}")
			render plain: "Post not found", status: :not_found and return
		end

		if @post['custom_template'] == 'custom-documentation'
			render "#{@app}/pages/post", layout: "#{@app}/layouts/docs"
		else
			render "#{@app}/pages/blog", layout: "#{@app}/layouts/blog"
		end
	end

	def blogs
		@posts = Rails.cache.fetch("blogs_#{@app}_page_#{params[:page] || 1}", expires_in: 1.hour) do
			ghost_client.get_posts(params[:page] || 1).select {|p| p['custom_template'] != 'custom-documentation'}
		end

		@posts = ghost_client.get_posts(params[:page] || 1).select {|p| p['custom_template'] != 'custom-documentation'} unless @posts.present?

		@fatured = @posts.select {|p| p['featured']}.first(3)

		render "#{@app}/pages/blogs", layout: "#{@app}/layouts/blog"
	end

	def featured
		render "#{@app}/pages/featured", layout: "#{@app}/layouts/application"
	end

	def about
		render "#{@app}/pages/about", layout: "#{@app}/layouts/application"
	end

	def contact
		render "#{@app}/pages/contact", layout: "#{@app}/layouts/application"
	end

	def process_page
		render "#{@app}/pages/process", layout: "#{@app}/layouts/application"
	end

	def code_review
		render "#{@app}/pages/code_review", layout: "#{@app}/layouts/application"
	end

	def portfolio
		render "#{@app}/pages/portfolio", layout: "#{@app}/layouts/portfolio"
	end

	def integrations
		render "#{@app}/pages/integrations", layout: "#{@app}/layouts/application"
	end

	def onboard
		render "#{@app}/pages/onboard", layout: "#{@app}/layouts/application"
	end

	def nesha
		render "#{@app}/pages/nesha", layout: "#{@app}/layouts/application"
	end

	private

	def ghost_client
		@ghost_client ||= GhostClient.new(@host)
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

	def resolve_app
		if request.host == 'kolosek.com'
			@app = 'kolosek'
			@host = 'kolosek.com'
		elsif request.host == 'fast.ci'
			@app = 'fastci'
			@host = 'fast.ci'
		elsif request.host == 'litetracker.com'
			@app = 'litetracker'
			@host = 'litetracker.com'
		elsif request.host == 'demo.litetracker.com'
			@app = 'litetracker'
			@host = 'demo.litetracker.com'
		else
			@app = 'rubyci'
			@host = 'ruby.ci'
		end
	end

	def set_posts
		if @host == 'kolosek.com'
			@posts  = Rails.cache.fetch("blogs_#{@app}_page_#{params[:page] || 1}", expires_in: 1.hour) do
				ghost_client.get_posts(params[:page] || 1).select {|p| p['custom_template'] != 'custom-documentation'}
			end
			@fatured = @posts.select {|p| p['featured']}.first
		end
	end
end
