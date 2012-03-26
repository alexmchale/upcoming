class CreatePasswordResets < ActiveRecord::Migration
  def change
    create_table :password_resets do |t|
      t.references :user
      t.string :uuid

      t.timestamps
    end
    add_index :password_resets, :user_id
  end
end
