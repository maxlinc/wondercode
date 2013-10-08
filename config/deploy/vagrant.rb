set :domain,      "localhost"
set :rails_env,   "production"

set :user, "wondercode"
set :mongoid_user, 'wondercode'
set(:mongoid_password) { Capistrano::CLI.ui.ask("Mongo password: ") }
set :ssh_options, {:port => 2222, :forward_agent => true, keys: ['wondercode_demo_rsa']}

set :default_environment, {
  'PATH' => "$HOME/.rbenv/shims:$HOME/.rbenv/bin:$PATH"
}