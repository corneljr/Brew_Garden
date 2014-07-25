class RewardsController < ApplicationController
  before_action :require_login, only: [:create, :destroy, :update]

  def show
    @reward = Reward.find(params[:id])
    @project = @reward.project
    @pledge = Pledge.new
  end

  def create
    @project = Project.find(params[:project_id])
  	@reward = @project.rewards.build(reward_params) 
    @reward.update_currency_for_save

  	if @reward.save
  		redirect_to project_path, notice: "Reward created successfully"
  	else
  		render 'project/show'
  	end

  end

  def destroy
  	@reward = Reward.find(params[:id])
  	@reward.destroy
  end

  def update
  	@reward = Reward.find(params[:id])
    @reward.assign_attributes(reward_params)
    @reward.update_currenct_for_save

  	if @reward.save
  		redirect_to project_path(@reward.project)
  	else
  		redirect_to project_path(@reward.project)
  	end	
  end

  private 

  def reward_params
  	params.require(:reward).permit(:amount, :description, :project_id, :pledges_left)
  end

end
