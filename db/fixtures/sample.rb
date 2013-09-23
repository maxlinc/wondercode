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
      languages: %w[a b c d],
      # tags: Array.new(2) { tags.sample }
    }
  )
end

Repository.all.each do |repo|
  repo.tags << tags.sample
  repo.tags << tags.sample
end