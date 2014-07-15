class SessionsController < ApplicationController
  def new
  end

  def create
  	user = User.find_by_email(params[:email])

  	if user && user.authenticate(params[:password])
  		session[:user_id] = user.id
  		redirect_to root_path
  	else
  		flash.now[:alert] = "Invalid Email or password"
  		render 'new', :notice => "notice unsuccessful"
  	end
  end

  def destroy
  	session[:user_id] = nil
  	redirect_to root_path, :notice => "Log Out Successful"
  end
end
