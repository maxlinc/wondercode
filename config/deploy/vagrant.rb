set :domain,      "localhost"
set :rails_env,   "production"

set :user, "wondercode"
set :mongoid_user, 'wondercode'
set :mongoid_password, 'wondercode123'
set :ssh_options, {:port => 2222, :forward_agent => true, keys: ['wondercode_demo_rsa']}

set :default_environment, {
  'PATH' => "$HOME/.rbenv/shims:$HOME/.rbenv/bin:$PATH",
  'MONGOLAB_URI' => "mongodb://#{mongoid_user}:#{mongoid_password}@dbh46.mongolab.com:27467/wondercoders-dev"
}