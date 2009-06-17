set :application, "barf"
set :scm, :git
set :repository,  "git://github.com/niklas/barf.git"
set :git_enable_submodules,1
set :local_repository, "."
set :branch, 'master'

set :deploy_to, "/usr/lib/cgi-bin/#{application}"

single_target = ENV['TARGET'] || "schnurr.local"
role :app, single_target
role :web, single_target
role :db,  single_target, :primary => true


namespace :deploy do
  desc "More symlinks"
  task :after_symlink, :roles => :app do
    config_dir = "#{deploy_to}/shared/config"
    run "mkdir -p #{config_dir}"
    run "ln -fs #{config_dir}/database.yml #{current_release}/config/database.yml"
    run "ln -fs #{config_dir}/app_config.yml #{current_release}/config/app_config.yml"
  end
end
