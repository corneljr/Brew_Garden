class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :null_session

  def load_project
    @project = Project.find(params[:project_id]) if params[:project_id]
  end

  private 

  def current_user
  	@current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def require_login
  	unless current_user
  		flash[:alert] = "You must login"
  		redirect_to new_session_path
  	end
  end
  helper_method :current_user

  # rescue_from ActionController::RoutingError do |exception|
  #   render 'public/404'
  # end

end
