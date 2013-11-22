require 'rvm/capistrano'  # to enable RVM integration
require 'bundler/capistrano'

set :application, "hydroflask"
set :repository,  "ssh://git@github.com/bobbobbins/hydro.git"

# set :scm, :git # You can set :scm explicitly or Capistrano will make an intelligent guess based on known version control directory names
# Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`

set :scm, :git
set :deploy_via, :remote_cache
set :git_enable_submodules, true
set :scm_verbose, true
set :use_sudo,    false
set :group_writable,  false # Setting HOME to g+w during deploy:setup will break ssh key authentication


# only keep the 5 most recently deployed releases
set :keep_releases, 5

#-----------------------------------------------------------------------------
# Special config options for SSH with 'pem' file
#default_run_options[:pty] = false   # Must be set for the password prompt from git to work
ssh_options[:forward_agent] = true  # uses local keys
#set :ssh_options, {:forward_agent => true}
#ssh_options[:auth_methods] = ["publickey"]
#ssh_options[:keys] = ["~/.ssh/hfkey.pem"]
#ssh_options[:keys] = ["~/pem_files/hfkey.pem"]
#-----------------------------------------------------------------------------

# see this link for capistrano multistage:
# http://cjohansen.no/en/rails/multi_staging_environment_for_rails_using_capistrano_and_mod_rails
set :stages, %w(production staging)  #%w(staging production)
require 'capistrano/ext/multistage'

# Files that remain on the server; we just update the softlinks when code is deployed
set :shared_files, %w(config/database.yml config/authorize_config.yml config/initializers/netsuite.rb)  #  config/facebook.yml


set :whenever_environment, defer { stage }
set :whenever_identifier, defer { "#{application}_#{stage}"  }
set :whenever_command, "bundle exec whenever"
require "whenever/capistrano"

namespace :config do
  desc "Copy shared files after deploy"
  task :copy_shared_files, :roles => :app do
    shared_files.each do |file|
      from = File.join(shared_path, file)
      to = File.join(release_path, file)
      run %Q[ln -nfs "#{from}" "#{to}"]
    end
    
    # also softlink the public/ckeditor_assets dir, which is where ckeditor uploaded images are stored
    run "ln -s #{shared_path}/ckeditor_assets #{release_path}/public/ckeditor_assets"
    
  end
end

# if you're still using the script/reaper helper you will need
# these http://github.com/rails/irs_process_scripts

# If you are using Passenger mod_rails uncomment this:
namespace :deploy do
  task :start do ; end
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end
end


# if you want to clean up old releases on each deploy uncomment this:
after "deploy:restart", "deploy:cleanup"

after "bundle:install", "config:copy_shared_files"
