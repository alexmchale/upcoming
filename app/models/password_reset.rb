class PasswordReset < ActiveRecord::Base

  belongs_to :user

  validates_presence_of :user
  validates_presence_of :email

  before_create :delete_other_resets
  before_create :generate_uuid

  def email
    user.email if user
  end

  def email= email
    self.user = User.find_by_email email
  end

  def to_param
    uuid
  end

  def self.find_by_uuid uuid, within = 2.hours
    PasswordReset.where("created_at >= ? AND uuid = ?", within.ago, uuid).first
  end

  protected

  def delete_other_resets
    user.password_resets.delete_all
  end

  def generate_uuid
    self.uuid = Digest::SHA1.hexdigest [ Time.now, email ].join
  end

end
