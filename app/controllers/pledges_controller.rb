class PledgesController < ApplicationController
  before_action :require_login, only: [:create]

	def show
		@pledge = Pledge.find(params[:id])
	end

  def create
    @reward = Reward.find(params[:reward_id])
  	@pledge = @reward.pledges.build(reward_id: @reward.id, user_id: current_user.id)
  	@pledge.user_id = current_user

  	if @pledge.save
      @reward.project.update_funded_amount
  		redirect_to @reward.project
  	else 
  		render :new
  	end
  end
end
