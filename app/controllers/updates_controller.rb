class UpdatesController < ApplicationController

	def index 
		@project = Project.find(params[:project_id])
		@updates = @project.updates

		if request.xhr?
			render partial: 'update_list'
		end
	end

	def new
		@project = Project.find(params[:project_id])
		@update = Update.new
	end

	def show 
	end

	def create
		@project = Project.find(params[:project_id])
		@update = @project.updates.build(update_params)
		if @update.save
			#UserMailer.update_email(@project, @update).deliver
			redirect_to @project
		else
			render :new
		end
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
