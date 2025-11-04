module ApplicationHelper
	def resolve_title_metadata(path)
		slug = path.sub(/^\//, '')
		page_metadata = PageMetadata.find_by_slug(slug)
		page_metadata.meta_title if page_metadata.present?
	end
end
