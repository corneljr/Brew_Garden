class UpdatesController < ApplicationController

	def index 
		@project = Project.find(params[:project_id])
		@updates = @project.updates
	end

	def new
		@update = Update.new
	end

	def show 
	end

	def create
		@project = Project.find(params[:project_id])
		@update = @project.updates.build(update_params)
	end

	def destroy
	end

	def edit
	end

	def update
	end

private
	
	def update_params
		params.require(:update).permit(:title, :body, :project_id)
	end
end
