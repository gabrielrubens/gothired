class CreateBlogPosts < ActiveRecord::Migration[8.0]
  def change
    create_table :blog_posts do |t|
      t.string :title, null: false
      t.string :slug, null: false
      t.text :content, null: false
      t.string :cover_image
      t.integer :reading_time
      t.boolean :featured, default: false
      t.string :category
      t.json :tags, default: [] # Use JSON instead of array (compatible with SQLite & PostgreSQL)
      t.datetime :published_at
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
