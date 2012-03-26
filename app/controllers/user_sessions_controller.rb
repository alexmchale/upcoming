class UserSessionsController < ApplicationController

  accepts fields: { user: %w( email password ) }, on: :create

  def new
    @user = User.new
  end

  def create
    @user = User.find_by_email params[:user][:email]

    if @user && @user.password?(params[:user][:password])
      sign_in @user
      flash[:notice] = "You are now signed in."
      if @user.searches.count > 0
        redirect_to searches_path
      else
        redirect_to new_search_path
      end
    elsif !@user && params[:user][:email].present?
      @user = User.new params[:user]
      @offer_to_create = true
      render "new"
    else
      flash[:error] = "That isn't a valid username and password combination. Please try again."
      redirect_to new_user_session_path
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to sign_in_path
  end

end
