FactoryBot.define do
  factory :software do
    name { Faker::Lorem.characters(number:5) }
    user
  end
end