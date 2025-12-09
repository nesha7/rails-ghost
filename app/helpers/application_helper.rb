module ApplicationHelper
	def resolve_title_metadata(path)
		slug = path.sub(/^\//, '')
		page_metadata = PageMetadata.find_by_slug(slug)
		page_metadata.meta_title if page_metadata.present?
	end

	def fix_missing_img_alts(html, alt)
	  doc = Nokogiri::HTML.fragment(html)

	  doc.css('img').each do |img|
	    if img['alt'].blank?
	      img['alt'] = alt
	    end
	  end

	  doc.to_html
	end

	def stored_utm_data
		session.to_h.slice(
			"utm_source",
			"utm_medium",
			"utm_term",
			"utm_content",
			"utm_campaign",
			"ref"
		).compact_blank
	end

	def app_login_url_with_utm(base_url, additional: {})
	  # Merge in additional parameters
	  query_params = stored_utm_data.merge(additional.compact_blank)

	  uri = URI(base_url)
	  uri.query = query_params.to_query if query_params.any?
	  uri.to_s
	end

	def handle_host_url(app)
		case app
		when 'litetrackercom'
			'https://app.litetracker.com'
		when 'kolosekcom'
			'https://kolosek.com'
		when 'rubyci'
			'https://ruby.ci'
		end
	end
end
