# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    nickname Faker::Internet.user_name
    email 'example@example.com'
    password Devise.friendly_token[0,20]
  end
end