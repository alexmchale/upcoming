class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def create
    @user = User.new params[:user]

    if @user.save
      sign_in @user

      flash[:notice] = "Welcome to Upcoming! Your user account #{@user.email} is now active."
      redirect_to new_search_path
    else
      render "new"
    end
  end

  protected

  def filter_parameters
    if params[:user]
      params[:user].slice! :email, :password
    end
  end

end
