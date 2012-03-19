class CreateSearchResults < ActiveRecord::Migration
  def change
    create_table :search_results do |t|
      t.references :search
      t.references :record

      t.timestamps
    end
    add_index :search_results, :search_id
    add_index :search_results, :record_id
  end
end
