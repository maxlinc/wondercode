require 'capistrano/ext/multistage'
require "bundler/capistrano"
require "dotenv/capistrano"

set :scm, :git
set :repository,  "file:///vagrant"
set :local_repository, '.'
set :application, 'wondercode'
set :use_sudo, false
set :unicorn_user, 'wondercode'

set :stages, Dir['config/deploy/*.rb'].map{|f| File.basename f, '.rb'} #%w(vagrant staging production)
set :default_stage, "vagrant"

set(:mongolab_uri) do
  mongoid_user = Capistrano::CLI.ui.ask("Mongoid User:")
  mongoid_pass = Capistrano::CLI.password_prompt("Mongoid Pass:")
  mongoid_uri  = Capistrano::CLI.ui.ask("Mongoid Server URI:")
  "mongodb://#{mongoid_user}:#{mongoid_pass}@#{mongoid_uri}"
end

set :bundle_flags, "--deployment --quiet --binstubs"

# role(:web) { domain }
# role(:app) { domain }
# role(:db, :primary => true) { domain }

set(:deploy_to)    { "/opt/apps/wondercode" }
set(:current_path) { File.join(deploy_to, current_dir) }

namespace :deploy do
 task :env_file do
  put "MONGOLAB_URI=\"#{mongolab_uri}\"", "#{shared_path}/.env"
 end
 task :start do 
  run "service unicorn_wondercode start"
 end
 task :stop do 
  run "service unicorn_wondercode stop"
 end
 task :restart, :roles => :app, :except => { :no_release => true } do
   run "service unicorn_wondercode restart"
 end
end

before 'deploy', 'deploy:setup'
after  'deploy:update_code', 'deploy:env_file'
before 'deploy:assets:precompile', 'deploy:env_file'