class PledgesController < ApplicationController
  before_action :require_login, only: [:create]

	def show
		@pledge = Pledge.find(params[:id])
	end

  def create
    @reward = Reward.find(params[:reward_id])
  	@pledge = @reward.pledges.build(pledge_params)
  	@pledge.user_id = current_user

  	if @pledge.save
      @reward.project.update_funded_amount
  		redirect_to project_path
  	else 
  		render :new
  	end
  end

  private
  def pledge_params
  	params.require(:pledge).permit(:amount, :reward_id, :user_id)
  end

end
