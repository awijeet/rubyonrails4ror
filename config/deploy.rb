#require "bundler/capistrano"
set :application, "rubyonrails4ror"
set :repository,  "."
set :scm, :none    
set :deploy_via, :copy
set :checkout, 'export'
set :user, 'root'
set :domain, 'rubyonrails4ror.com'
set :use_sudo, TRUE
# Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`
set :applicationdir, "/var/www/#{application}"
set :deploy_to, applicationdir
role :web, domain            # Your HTTP server, Apache/etc
role :app, domain            # This may be the same as your `Web` server
role :db,  domain, :primary => true # This is where Rails migrations will run
#role :db,  "208.111.45.210"

# if you want to clean up old releases on each deploy uncomment this:
# after "deploy:restart", "deploy:cleanup"

# if you're still using the script/reaper helper you will need
# these http://github.com/rails/irs_process_scripts
set :chmod755, "app config db lib public vendor script script/* public/disp*"
# If you are using Passenger mod_rails uncomment this:
namespace :deploy do
  task :start do ; end
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end
end