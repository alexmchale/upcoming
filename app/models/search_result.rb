class SearchResult < ActiveRecord::Base

  belongs_to :search
  belongs_to :record

  after_create :notify_user

  attr_accessor :send_email

  protected

  def notify_user
    if search.monitor_by_email && send_email
      UserMailer.record_added(search, record).deliver
    end
  end

end
