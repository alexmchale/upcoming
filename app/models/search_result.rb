class SearchResult < ActiveRecord::Base

  belongs_to :search
  belongs_to :record

  after_create :notify_user

  protected

  def notify_user
    if search.monitor_by_email
      UserMailer.record_added(search, record).deliver
    end
  end

end
