FactoryBot.define do
  factory :post do
    twitter { Faker::Lorem.characters(number:20) }
    software_id { 1 }
    brush { Faker::Lorem.characters(number:5) }
    user
    software
  end
end