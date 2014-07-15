class RewardsController < ApplicationController
  def create
    @project = Project.find(params[:project_id])
  	@reward = @project.rewards.build(reward_params) 

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

  	if @product.update_attributes(reward_params)
  		redirect_to project_path(@project)
  	else
  		redirect_to project_path(@project)
  	end
  	
  end

  private 
  def reward_params
  	params.require(:reward).permit(:amount, :description, :project_id)
  end
end
