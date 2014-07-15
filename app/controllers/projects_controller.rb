class ProjectsController < ApplicationController

	def index
		@projects = Project.all
	end

	def show
		@project = Project.find(params[:id])
		@rewards = @project.rewards
	end

	def new 
		@project = Project.new
		@project.rewards.build
	end

	def create
		binding.pry
		@project = Project.new(project_params)
		@project.save
	end

	def update
		@project = Project.find(params[:id])
		@project.update(project_params)
		@project.save
		redirect_to @project
	end

	def destroy
		Project.find(params[:id]).destroy
	end

	def edit
		@project = Project.find(params[:id])
		@rewards = @project.rewards
	end

private
	
	def project_params
		params.require(:project).permit(:title, :description, :end_date, :goal, rewards_attributes: [:amount, :description, :_destroy])
	end
end
