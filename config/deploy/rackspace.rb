require 'fog'

set(:fog_connection) do
  Fog::Compute.new({
    :provider            => 'Rackspace',         # Rackspace Fog provider
    :rackspace_username  => ENV['RAX_USERNAME'], # Your Rackspace Username
    :rackspace_api_key   => ENV['RAX_API_KEY'],  # Your Rackspace API key
    :version             => :v2                 # Use Next Gen Cloud Servers
  })
end

set :version, 1
set(:image_server) do
  server = fog_connection.servers.find { |server|
    server.name == 'wondercode-image'
  }
end

set(:domain) do
  image_server.access_ipv4_address
end

set :rails_env,   "production"

set :user, "wondercode"
set :mongoid_user, 'wondercode'
set(:mongoid_password) { Capistrano::CLI.ui.ask("Mongo password: ") }
set :ssh_options, {:forward_agent => true, keys: ['wondercode_demo_rsa']}

set :default_environment, {
  'PATH' => "$HOME/.rbenv/shims:$HOME/.rbenv/bin:$PATH"
}

task :create_image do
  image = image_server.create_image "wondercode_#{version}"
  image.wait_for { ready? }
end