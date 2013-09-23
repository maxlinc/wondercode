require 'faker'

FactoryGirl.define do
  factory :repo, class: Repository do
    name Faker::Lorem.word
    login Faker::Internet.user_name
    repo_url Faker::Internet.url
  end
end