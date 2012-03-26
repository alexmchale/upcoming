class ApplicationController < ActionController::Base

  include ActionController::ParameterFilter

  protect_from_forgery

  before_filter :set_no_cache

  helper_method :current_or_guest_user, :current_user

  protected

  # if user is logged in, return current_user, else return guest_user
  def current_or_guest_user
    if current_user
      if session[:guest_user_id]
        logging_in
        guest_user.destroy
        session[:guest_user_id] = nil
      end
      current_user
    else
      guest_user
    end
  end

  private

  # find guest_user object associated with the current session,
  # creating one as needed
  def guest_user
    @_guest_user ||= User.find(session[:guest_user_id].nil? ? session[:guest_user_id] = create_guest_user.id : session[:guest_user_id])
  end

  def create_guest_user
    email = "guest_#{Time.now.to_i}#{rand(99)}@example.com"
    User.create! email: email
  end

  def current_user
    @_current_user ||= User.find(session[:user_id]) if session[:user_id].present?
  end

  def sign_in user
    session[:user_id] = user.id
  end

  def sign_out
    session[:user_id] = nil
  end

  # called (once) when the user logs in, insert any code your application needs
  # to hand off from guest_user to current_user.
  def logging_in
    guest_user.searches.update_all user_id: current_user.id
    guest_user.reload
    current_user.reload
  end

  def set_no_cache
    response.headers["Cache-Control"] = "no-cache, no-store, max-age=0, must-revalidate"
    response.headers["Pragma"] = "no-cache"
    response.headers["Expires"] = "Fri, 01 Jan 1990 00:00:00 GMT"
  end

end
