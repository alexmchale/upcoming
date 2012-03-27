class AddAcknowledgedToSearchResults < ActiveRecord::Migration

  def change
    add_column :search_results, :acknowledged, :boolean, default: false
  end

end
