class RewardsController < ApplicationController
  before_action :require_login, only: [:create, :destroy, :update]

  def show
    @reward = Reward.find(params[:id])
    @project = @reward.project
    @pledge = Pledge.new
  end

  def destroy
  	@reward = Reward.find(params[:id])
  	@reward.destroy
  end

  private 

  def reward_params
  	params.require(:reward).permit(:amount, :description, :project_id, :pledges_left)
  end

end
