# Change these

set :application, '{{app_name}}'
set :repo_url, '{{repo_url}}'
set :deploy_to, '/www/{{app_name}}'
set :log_level, :debug
set :linked_files, %w{config/database.yml}
set :linked_dirs, %w{tmp/sockets tmp/pids log public/system}

namespace :deploy do
  task :restart do
    invoke 'unicorn:restart'
  end
end
