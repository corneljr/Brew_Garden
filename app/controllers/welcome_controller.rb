class WelcomeController < ApplicationController

  def index
  	# @total_funding = Project.all.sum(:funded_amount)
    @most_funded = Project.all.order('funded_amount DESC').limit(3)
    @projects = Project.all

	  respond_to do |format|
	  		format.html
	  		format.json { render json: @geojson }
	  end
  end

  def contact
    UserMailer.contact_us_email(contact_params).deliver
    redirect_to root_path, notice: "Your email has been sent!"
  end

  private
    def contact_params
      params.require(:contact).permit(:name, :email, :message)
    end

end
