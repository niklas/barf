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
