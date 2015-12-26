# Change this to your host. See the readme at https://github.com/lassebunk/dynamic_sitemaps
# for examples of multiple hosts and folders.
host "www.super80sworld.com"

sitemap :site do
  url root_url, last_mod: Time.now, change_freq: "daily", priority: 1.0
  url video_url, last_mod: Time.now, change_freq: "daily", priority: 1.0
  url screenshots_url, last_mod: Time.now, change_freq: "daily", priority: 1.0
  url press_url, last_mod: Time.now, change_freq: "daily", priority: 1.0
  url press_kit_url, last_mod: Time.now, change_freq: "daily", priority: 1.0

  Comfy::Blog::Post.published.each do |post|
    url "/#{post.slug}", last_mod: post.updated_at, priority: 1.0
  end
end