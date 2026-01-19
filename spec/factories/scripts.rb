FactoryBot.define do
  factory :script do
    key { Faker::Lorem.word }
    value { { 'data' => Faker::Lorem.sentence } }
  end
end
