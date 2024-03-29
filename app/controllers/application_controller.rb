class ApplicationController < ActionController::Base

  #include ParameterFilter

  protect_from_forgery

  before_filter :set_no_cache
  before_filter :find_unacknowledged_search_results

  layout :set_layout

  helper_method :current_or_guest_user, :current_user

  protected

  # if user is logged in, return current_user, else return guest_user
  def current_or_guest_user
    if current_user
      if session[:guest_user_id]
        logging_in
        guest_user.destroy
        session.delete :guest_user_id
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
    return @_guest_user if @_guest_user

    @_guest_user = User.find_by_id session[:guest_user_id]

    unless @_guest_user
      email = "guest_#{Time.now.to_i}#{rand(99)}@example.com"
      @_guest_user = User.create! email: email
      session[:guest_user_id] = @_guest_user.id
    end

    @_guest_user
  end

  def current_user
    @_current_user ||= User.find(session[:user_id]) if session[:user_id].present?
  end

  def sign_in user
    session[:user_id] = user.id
    user
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

  def find_unacknowledged_search_results
    @unacknowledged_search_results =
      current_or_guest_user.
      search_results.
      unacknowledged.
      includes(:search, :record).
      order("created_at DESC").
      all
  end

  def set_layout
    if request.headers['X-PJAX']
      false
    else
      "application"
    end
  end

end
