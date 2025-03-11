class CreateJobPosts < ActiveRecord::Migration[8.0]
  def change
    create_table :job_posts do |t|
      t.string :tittle
      t.float :match_score

      t.timestamps
    end
  end
end
