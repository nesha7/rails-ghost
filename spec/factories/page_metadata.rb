FactoryBot.define do
  factory :page_metadata do
    slug { Faker::Internet.slug }
    meta_title { Faker::Lorem.sentence }
  end
end
