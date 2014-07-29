class UsersController < ApplicationController
  before_action :load_user, only: [:edit, :update, :show, :projects, :pledges, :comments]
  before_action :require_login, only: [:edit, :update]

  def new
    @user = User.new
  end

  def edit
    if current_user != @user
      redirect_to projects_path, alert: 'Whooaaaaaaaaa, not your profile bud.'
    end
  end

  def update
    if @user.update(user_params)
      redirect_to @user
    else
      render :edit
    end
  end

  def show
    @projects = @user.projects.where(post_status: true)
    @saved_projects = @user.projects.where(post_status: false)
    @comments = @user.comments
    @pledges = @user.pledges
  end

  def create
    @user = User.new(user_params)
    if @user.save
      UserMailer.welcome_email(@user).deliver
      user = login(params[:user][:email], params[:user][:password])
      redirect_to projects_url, :notice => "Signed up!"
    else
      render :new
    end
  end

  def pledges
    if request.xhr?
      render partial: 'user_pledges'
    end
  end

  def projects
    if request.xhr?
      render partial: 'user_projects'
    end
  end

  def comments
    if request.xhr?
      render partial: 'user_comments'
    end
  end

  private

  def user_params
  	params.require(:user).permit(:email, :name, :password, :password_confirmation, :avatar)
  end

  def load_user
    @user = User.find(params[:id])
  end
end
