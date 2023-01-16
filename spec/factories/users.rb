FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    user_name { 'test' }
    password { 'password' }
    password_confirmation { 'password' }
    image { 'http://example.com/example.png' }
  end
end
