class UserMailer < ActionMailer::Base

  default from: "upcoming@anticlever.com"

  def record_added search, record
    @search = search
    @record = record
    @user = @search.user
    @style = @search.style.singularize
    @subject = "New %s found on search `%s`: %s" % [ @style, @search.term, @record.name ]

    mail to: @user.email, subject: @subject
  end

end
