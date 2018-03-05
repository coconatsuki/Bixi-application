FactoryBot.define do
  factory :station do
    name { Faker::Space.star }
    latitude { Faker::Address.latitude }
    longitude { Faker::Address.longitude }
    distance_from_office { Faker::Number.decimal(1, 5) }
    address { Faker::Address.street_address }
    bixi_id { Faker::Number.number(4) }
  end
end
