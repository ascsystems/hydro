set :user, 'ec2-user' # The server's user for deploys
set :deploy_to, "/var/www/hydroflask/staging"
set :rails_env, "staging"

set :domain, '54.213.130.113'
#set :port, '2222' # for non-standard SSH port

role :web, domain                         # Your HTTP server, Apache/etc
role :app, domain                         # This may be the same as your `Web` server
role :db,  domain, :primary => true # This is where Rails migrations will run

ssh_options[:keys] = ["~/.ssh/hfkey.pem"]

# rvm gemset to use on the server (different than production gemset)
set :rvm_ruby_string, '2.0.0-p247@hydroflask-staging'
set :rvm_type, :user   # this needs to be ':user'; this is not the name of the username on the server

# special branch to deploy (if you ever need to deploy a non-master branch)
#set :branch, <special_branch_name>  
