max_threads_count = ENV.fetch("RAILS_MAX_THREADS") { 5 }
min_threads_count = ENV.fetch("RAILS_MIN_THREADS") { max_threads_count }
threads min_threads_count, max_threads_count

port        ENV.fetch("PORT") { 3000 }
application_path = "/home/deploy/super_80s_website"

bind "unix://#{application_path}/shared/sockets/puma.sock"

environment ENV.fetch("RAILS_ENV") { "development" }

pidfile ENV.fetch("PIDFILE") { "tmp/pids/server.pid" }

workers ENV.fetch("WEB_CONCURRENCY") { 2 }
stdout_redirect "#{shared_dir}/log/puma.stdout.log", "#{shared_dir}/log/puma.stderr.log", true

preload_app!

# Allow Puma to be restarted by the `Rails restart` command.
plugin :tmp_restart