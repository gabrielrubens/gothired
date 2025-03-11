class RenameTittleToTitleInJobPosts < ActiveRecord::Migration[8.0]
  def change
    rename_column :job_posts, :tittle, :title
  end
end
