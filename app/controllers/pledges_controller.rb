class PledgesController < ApplicationController
  before_action :require_login, only: [:create]

	def show
		@pledge = Pledge.find(params[:id])
	end

  def create
    @reward = Reward.find(params[:reward_id])
    @project = Reward.find(params[:project_id])

  	@pledge = @reward.pledges.build(pledge_params)
    @pledge.user_id = current_user.id
    @pledge.project_id = @project.id

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

  def pledge_params
    params.require(:pledge).permit(:address, :city, :postal_code, :province)
  end
end
