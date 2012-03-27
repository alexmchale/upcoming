class UsersController < ApplicationController

  #accepts fields: { user: %w( email password ) }, on: %w( create update )

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

  def edit
    @user = current_user
  end

  def update
    @user = current_user

    if @user.update_attributes params[:user]
      flash[:notice] = "Your user account has been updated."
    else
      flash[:error] = @user.errors.full_messages.first
    end

    redirect_to edit_user_path @user.reload
  end

end
