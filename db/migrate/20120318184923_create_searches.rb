class CreateSearches < ActiveRecord::Migration
  def change
    create_table :searches do |t|
      t.references :retailer
      t.text :parameters
      t.text :response

      t.timestamps
    end
    add_index :searches, :retailer_id
  end
end
