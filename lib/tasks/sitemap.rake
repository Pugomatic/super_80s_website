namespace :sitemap do
  task :symlink do
    system("cp #{Rails.root}/public/sitemaps/sitemap.xml #{Rails.root}/public/sitemap.xml")
  end
end

namespace :symlinks do
  desc "generate and copy the symlink"
  task :generate_sitemap do
    run "cd #{release_path} && RAILS_ENV=production bundle exec rake sitemap:generate"
    run "cd #{release_path} && RAILS_ENV=production bundle exec rake sitemap:symlink"
  end
end
