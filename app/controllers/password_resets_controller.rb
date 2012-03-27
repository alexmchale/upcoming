class PasswordResetsController < ApplicationController

  #accepts fields: { password_reset: :email }, on: :create

  def new
    @password_reset = PasswordReset.new
  end

  def create
    @password_reset = PasswordReset.new params[:password_reset]

    if @password_reset.save
      UserMailer.password_reset(@password_reset).deliver
      flash[:notice] = "Password reset instructions have been mailed to you."
      redirect_to root_path
    else
      render "new"
    end
  end

  def edit
    @password_reset = PasswordReset.find_by_uuid params[:id]

    if @password_reset
      @user = @password_reset.user
      sign_in @user
      @password_reset.destroy
    else
      flash[:error] = "That is an invalid password reset code. Please try again."
      redirect_to new_password_reset_path
    end
  end

end
