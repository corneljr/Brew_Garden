class SessionsController < ApplicationController
  def new 
    session[:previous_page] = request.env['HTTP_REFERER'] 
  end  
    
  def create 
    user = login(params[:email], params[:password], params[:remember_me])  
    if user
      url = session[:previous_page] || root_url 
      redirect_to url, notice: "Logged in!"  
    else  
      flash.now[:alert] = "Email or password was invalid." 
      render 'new'
    end  
  end 

  def destroy
	  session[:user_id] = nil 
	  redirect_to root_url, notice: "Logged out!"  
	end  
end
