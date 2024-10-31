class PagesController < ApplicationController
	def post
		@posts = ghost_client.get_posts.reverse
		@post = request.path == '/docs' ? 
			@posts.select {|p| p['custom_template'] == 'custom-documentation'}.first : ghost_client.get_post(request.path)

		if @post['custom_template'] == 'custom-documentation'
			render layout: 'docs'
		else
			render 'pages/blog', layout: 'blog'
		end
	end

	def blogs
		@posts = ghost_client.get_posts.select {|p| p['custom_template'] != 'custom-documentation'}
		@fatured = @posts.select {|p| p['featured']}.first(3)

		render layout: 'blog'
	end

	private

	def ghost_client
		@ghost_client ||= GhostClient.new
	end
end
