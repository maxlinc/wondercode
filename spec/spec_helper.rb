require File.expand_path("../../config/environment", __FILE__)
require 'devise'
require 'rspec/rails'
RSpec.configure do |config|
  config.include Devise::TestHelpers, :type => :controller

  config.order = "random"
  
  config.before(:suite) do
    DatabaseCleaner.strategy = :truncation
  end
  config.before(:each) do
    DatabaseCleaner.start
  end
  config.after(:each) do
    DatabaseCleaner.clean
  end
end
