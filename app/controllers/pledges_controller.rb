class PledgesController < ApplicationController
  before_action :require_login, only: [:create]

	def show
		@pledge = Pledge.find(params[:id])
	end

  def create
    @reward = Reward.find(params[:reward_id])
  	@pledge = @reward.pledges.build(reward_id: @reward.id, user_id: current_user.id)
    if pledge_check?
      redirect_to @reward.project, notice: "No more backers allowed."
    else
      @reward.add_backer
      @reward.project.update_funded_amount
      @pledge.save
      @reward.save
      redirect_to @reward.project
  	end
  end

  private

  def pledge_check?
    @reward.pledges_left == 0
  end
end
