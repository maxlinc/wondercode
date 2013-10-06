require 'capistrano-unicorn'

set :deploy_via, :copy
set :repository,  "."
set :copy_cache, true
set :copy_exclude, %w(.git)
set :application, 'wondercode'
set :use_sudo, false

set :stages, %w(vagrant staging production)
set :default_stage, "vagrant"
require 'capistrano/ext/multistage'

require "bundler/capistrano"
set :bundle_flags, "--deployment --quiet --binstubs"
set :default_environment, {
  'PATH' => "$HOME/.rbenv/shims:$HOME/.rbenv/bin:$PATH"
}

role(:web) { domain }
role(:app) { domain }
role(:db, :primary => true) { domain }

set(:deploy_to)    { "/opt/apps" }
set(:current_path) { File.join(deploy_to, current_dir) }

after 'deploy:restart', 'unicorn:reload'    # app IS NOT preloaded
after 'deploy:restart', 'unicorn:restart'   # app preloaded
after 'deploy:restart', 'unicorn:duplicate' # before_fork hook implemented (zero downtime deployments)