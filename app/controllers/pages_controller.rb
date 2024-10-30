class PagesController < ApplicationController
	def post
		@posts = ghost_client.get_posts.reverse
		@post = request.path == '/docs' ? @posts.first : ghost_client.get_post(request.path)

		render layout: 'docs'
	end

	private

	def ghost_client
		@ghost_client ||= GhostClient.new
	end
end
