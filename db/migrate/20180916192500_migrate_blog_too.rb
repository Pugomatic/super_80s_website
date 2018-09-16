class MigrateBlogToo < ActiveRecord::Migration[5.2]
  def change
    rename_column  :comfy_blog_posts, :content, :content_cache
  end
end
