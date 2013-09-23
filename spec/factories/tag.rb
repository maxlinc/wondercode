# # Read about factories at https://github.com/thoughtbot/factory_girl
require 'faker'

FactoryGirl.define do
  factory :github_repo_tag, class: Tag do
    name "#{Faker::Lorem.word}::#{Faker::Lorem.word}"
  end
end