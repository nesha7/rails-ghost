class PageMetadata < ApplicationRecord
	validates :slug, presence: true, uniqueness: true
end