set :domain,      "localhost"
set :rails_env,   "production"

set :user, "wondercode"
set :ssh_options, {:port => 2222, :forward_agent => true, keys: ['wondercode_demo_rsa']}