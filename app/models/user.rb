class User < ActiveRecord::Base

  EMAIL_REGEX = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i

  include BCrypt

  has_many :searches

  validates_uniqueness_of :email
  validates_presence_of :email
  validates_format_of :email, with: EMAIL_REGEX

  def any_monitored_searches?
    searches.where(monitor_by_email: true).count > 0
  end

  def password
    @password ||= Password.new encrypted_password
  end

  def password= new_password
    if new_password.present?
      @password = Password.create new_password
      self.encrypted_password = @password
    else
      @password = nil
      self.encrypted_password = ""
    end
  end

  def password? password
    return password.blank? if self.encrypted_password.blank?
    return self.password == password
  end

end
