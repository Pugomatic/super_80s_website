class Comfy::Blog::Post
  after_commit  :update_sitemap

  def update_sitemap
    system("RAILS_ENV=#{Rails.env} bundle exec rake sitemap:generate")
    system("RAILS_ENV=#{Rails.env} bundle exec rake sitemap:symlink")
  end
end