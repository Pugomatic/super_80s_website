lock '3.4.0'

set :rvm_type, :system
set :rvm1_ruby_version, "ruby-2.2.2"

set :application,     'super_80s_website'
set :port,            22
set :user,            'deploy'
set :puma_threads,    [4, 16]
set :puma_workers,    0
set :branch,          ENV["REVISION"] || ENV["BRANCH_NAME"] || 'master'

set :linked_files,    %w(config/database.yml config/secrets.yml)
set :linked_dirs,     %w{public/system}

set :repo_url,        'git@github.com:Pugomatic/super_80s_website.git'

set :ssh_options,     { verbose: :debug }
set :format,          :pretty
set :log_level,       :debug
set :pty,             true
set :use_sudo,        false
set :stage,           :production
set :deploy_via,      :remote_cache
set :deploy_to,       "/home/rails/apps/#{fetch(:application)}"
set :puma_bind,       "unix://#{shared_path}/tmp/sockets/outrun-the-80s-puma.sock"
set :puma_state,      "#{shared_path}/tmp/pids/puma.state"
set :puma_pid,        "#{shared_path}/tmp/pids/puma.pid"
set :puma_access_log, "#{release_path}/log/puma.error.log"
set :puma_error_log,  "#{release_path}/log/puma.access.log"
set :ssh_options,     { forward_agent: true, user: fetch(:user), keys: %w(~/.ssh/id_rsa.pub) }
set :puma_preload_app, true
set :puma_worker_timeout, nil
set :puma_init_active_record, true

namespace :puma do
  desc 'Create Directories for Puma Pids and Socket'
  task :make_dirs do
    on roles(:app) do
      execute "mkdir #{shared_path}/tmp/sockets -p"
      execute "mkdir #{shared_path}/tmp/pids -p"
    end
  end

  before :start, :make_dirs
end

namespace :deploy do
  desc "upgrade rails."
  task :upgrade_rails do
    on roles(:app) do
      execute "rvm use ruby-2.2.2 --default"
      execute "bundle update"
      execute "rails app:update"
    end
  end
  
  desc "Show env vars."
  task :env do
    on roles(:app) do
      execute "env"
    end
  end

  desc "Make sure local git is in sync with remote."
  task :check_revision do
    on roles(:app) do
      unless `git rev-parse HEAD` == `git rev-parse origin/master`
        puts "WARNING: HEAD is not the same as origin/master"
        puts "Run `git push` to sync changes."
        exit
      end
    end
  end

  desc 'Initial Deploy'
  task :initial do
    on roles(:app) do
      before 'deploy:restart', 'puma:stop'
      before 'deploy:restart', 'puma:start'
      invoke 'deploy'
    end
  end

  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      invoke 'puma:restart'
    end
  end

  before :starting,     :check_revision
  after  :finishing,    :compile_assets
  after  :finishing,    :cleanup
  after  :finishing,    :restart
end

namespace :sitemap do
  desc 'Generate sitemap'
  task :generate do
    on roles(:app) do
      execute "rake sitemap:generate"
    end
  end
end

# ps aux | grep puma    # Get puma pid
# kill -s SIGUSR2 pid   # Restart puma
# kill -s SIGTERM pid   # Stop puma