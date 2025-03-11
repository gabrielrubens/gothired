class CreateBetaSignups < ActiveRecord::Migration[8.0]
  def change
    create_table :beta_signups do |t|
      t.string :email

      t.timestamps
    end
    add_index :beta_signups, :email
  end
end
