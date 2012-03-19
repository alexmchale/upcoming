class CreateRecords < ActiveRecord::Migration
  def change
    create_table :records do |t|
      t.references :retailer
      t.string :code
      t.string :name
      t.text :artwork_url
      t.string :genre
      t.string :rating
      t.text :description
      t.date :release_date
      t.text :url
      t.string :type
      t.text :result

      t.timestamps
    end
    add_index :records, :retailer_id
  end
end
