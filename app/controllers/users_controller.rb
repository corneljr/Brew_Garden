class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def edit 
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    @user.update(user_params)
    if @user.save
      redirect_to @user
    else
      render :edit, notice: 'there was an error'
    end
  end

  def create
    @user = User.new(user_params)
    if @user.save
      # UserMailer.welcome_email(@user).deliver
      redirect_to root_url, :notice => "Signed up!"
    else
      render :new
    end
  end

  private

  def user_params
  	params.require(:user).permit(:email, :name, :password, :password_confirmation)
  end
end
