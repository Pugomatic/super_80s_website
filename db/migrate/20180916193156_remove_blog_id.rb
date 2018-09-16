class RemoveBlogId < ActiveRecord::Migration[5.2]
  def change
    remove_column :comfy_blog_posts, :blog_id
  end
end
