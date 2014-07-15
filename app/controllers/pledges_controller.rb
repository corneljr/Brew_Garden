class PledgesController < ApplicationController
	def new
		@pledge = Pledge.new
	end

  def create
  	@pledge = @project.pledges.build(pledge_params)
  	@pledge.user_id = current_user

  	if @pledge.save
  		redirect_to project_path
  	else 
  		render :new
  	end
  end

  def destroy
  	@pledge = Pledge.find(params[:id])
  	@pledge.destroy
  end

  def update
  	@pledge = Pledge.find(params[:id])

  	if @pledge.update_attributes(pledge_params)
  		redirect_to project_path(@project)
  	else
  		redirect_to project_path(@project)
  	end

  end

  private
  def pledge_params
  	params.require(:pledge).permit(:amount, :reward_id, :user_id)
  end

end
