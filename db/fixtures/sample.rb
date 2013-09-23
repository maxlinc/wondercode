def random_languages
  langs = %w[ruby python php node c++ java]
  Array.new((1..5).to_a.sample) { langs.sample }
end

Tag.seed(:name,
  { :name => 'rubyguy::faker'},
  { :name => 'rails::rails'},
  { :name => 'joyent::node'},
  { :name => 'rspec::rspec'},
  { :name => 'cucumber::cucumber'}
)
tags = Tag.all

20.times do 
  Repository.seed(:login, :name,
    {
      name: Faker::Lorem.word,
      login: Faker::Internet.user_name,
      repo_url: Faker::Internet.url,
      avatar_url: "https://identicons.github.com/#{Faker::Address.state_abbr}.png",
      description: Faker::Lorem.paragraph,
      languages: random_languages
      # tags: Array.new(2) { tags.sample }
    }
  )
end

Repository.all.each do |repo|
  repo.tags << tags.sample
  repo.tags << tags.sample
end