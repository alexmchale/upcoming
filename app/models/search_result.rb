class SearchResult < ActiveRecord::Base

  belongs_to :search
  belongs_to :record

  delegate :user, to: :search

  scope :unacknowledged, where(acknowledged: false)
  scope :acknowledged, where(acknowledged: true)

  def email?
    search.monitor_by_email && record.release_date.to_date >= search.created_at.to_date
  end

end
