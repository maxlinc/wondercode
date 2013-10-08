# require 'capistrano-unicorn'
# require "dotenv/capistrano"

set :scm, :none
set :deploy_via, :copy
set :repository,  "."
set :copy_via, :scp
set :copy_exclude, %w(.git)
set :application, 'wondercode'
set :use_sudo, false
set :unicorn_user, 'wondercode'

set :stages, %w(vagrant staging production)
set :default_stage, "vagrant"
require 'capistrano/ext/multistage'

require "bundler/capistrano"
set :bundle_flags, "--deployment --quiet --binstubs"

role(:web) { domain }
role(:app) { domain }
role(:db, :primary => true) { domain }

set(:deploy_to)    { "/opt/apps" }
set(:current_path) { File.join(deploy_to, current_dir) }

namespace :deploy do
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
# after 'deploy:restart', 'unicorn:reload'    # app IS NOT preloaded
# after 'deploy:restart', 'unicorn:restart'   # app preloaded
# after 'deploy:restart', 'unicorn:duplicate' # before_fork hook implemented (zero downtime deployments)