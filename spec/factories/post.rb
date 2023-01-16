FactoryBot.define do
  factory :post do
    twitter { Faker::Lorem.characters(number:20) }
    brush { Faker::Lorem.characters(number:5) }
    user
    software
  end
end