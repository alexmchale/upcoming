class UserMailer < ActionMailer::Base

  default from: "upcoming@anticlever.com"

  def record_added search, record
    @search  = search
    @record  = record
    @user    = @search.user
    @style   = @search.style.singularize.downcase
    @subject = "[Upcoming] New %s found: %s" % [ @style, @record.name ]

    mail to: @user.email, subject: @subject
  end

  def records_added user, results
    return if results.blank?

    @user    = user
    @results = results
    @subject = "[Upcoming] New search results found"

    mail to: @user.email, subject: @subject
  end

end
