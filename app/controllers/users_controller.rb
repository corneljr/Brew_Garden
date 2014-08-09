class UsersController < ApplicationController
  before_action :load_user, only: [:edit, :update, :show, :projects, :pledges, :comments, :upload_image, :saved]
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
    @saved_projects = @user.projects.where(post_status: false)
    @projects = @user.projects.where(post_status: true)
    @comments = @user.comments
    @pledges = Project.find(@user.pledges.pluck(:project_id).uniq)
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
    @pledges = Project.find(@user.pledges.pluck(:project_id).uniq)

    if request.xhr?
      render partial: 'user_pledges'
    end
  end

  def projects
    @projects = @user.projects.where(post_status: true)
    if request.xhr?
      render partial: 'user_projects'
    end
  end

  def comments
    @comments = @user.comments
    if request.xhr?
      render partial: 'user_comments'
    end
  end

  def saved
     @saved_projects = @user.projects.where(post_status: false)
     if request.xhr?
      render partial: 'user_saved'
    end
  end

  def upload_image
    @user.avatar = params[:avatar]
    @user.save(validate: false)
    redirect_to @user
  end

  private

  def user_params
  	params.require(:user).permit(:type, :email, :name, :password, :password_confirmation, :avatar, :facebook, :twitter, :website)
  end

  def load_user
    @user = User.find(params[:id])
  end
end
