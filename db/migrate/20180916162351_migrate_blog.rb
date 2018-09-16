class MigrateBlog < ActiveRecord::Migration[5.2]
  def change
    add_column  :comfy_blog_posts, :site_id, :integer
    add_column  :comfy_blog_posts, :layout_id, :integer
  end
end
