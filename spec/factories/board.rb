FactoryBot.define do
  factory :board do
    headline { Faker::Lorem.characters(number:10) }
    question { Faker::Lorem.characters(number:30) }
    user
  end
end