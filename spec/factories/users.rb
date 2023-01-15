FactoryBot.define do
  factory :user do
    email { 'user@email.com' }
    user_name { 'test' }
    password { 'password' }
    password_confirmation { 'password' }
  end
end
