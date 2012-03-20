class AddMonitoringByEmailToSearches < ActiveRecord::Migration

  def change
    add_column :searches, :monitor_by_email, :boolean, default: false
  end

end
