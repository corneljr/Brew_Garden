class UsersController < ApplicationController
  before_action :load_user, only: [:edit, :update, :show]

  def new
    @user = User.new
  end

  def edit 
  end

  def update
    @user.update(user_params)
    if @user.save
      redirect_to @user
    else
      render :edit, notice: 'there was an error'
    end
  end

  def show
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

  def load_user
    @user = User.find(params[:id])
  end
end
