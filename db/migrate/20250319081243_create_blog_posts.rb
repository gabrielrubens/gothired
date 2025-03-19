class CreateBlogPosts < ActiveRecord::Migration[8.0]
  def change
    create_table :blog_posts do |t|
      t.string :title
      t.string :slug
      t.text :content
      t.string :cover_image
      t.integer :reading_time
      t.boolean :featured
      t.string :category
      t.references :user, null: false, foreign_key: true
      t.datetime :published_at

      t.timestamps
    end
  end
end
