class AddIndexesToBlogPosts < ActiveRecord::Migration[8.0]
  def change
    add_index :blog_posts, :slug, unique: true
    add_index :blog_posts, :category
  end
end
