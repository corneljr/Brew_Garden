class ProjectsController < ApplicationController

	def index
		type = params[:type]
		@projects = if !type || type == 'all'
			Project.all
		else
			Project.where(category: params[:type])
		end

		@total_funding = Project.all.sum(:funded_amount)

		@most_funded = Project.all.order('funded_amount DESC').limit(4)
		@newest = Project.order('created_at DESC').limit(4)
		@near = Project.near('Toronto, ontario, canada', 20).limit(4) 

		respond_to do |format|
			format.html
			format.js
		end
	end

	def show
		@project = Project.find(params[:id])
		@rewards = @project.rewards
		@commentable = find_commentable
  	@comments = @project.comments
	end

	def new 
		@project = Project.new
		@project.rewards.build
	end

	def create
		binding.pry
		@project = Project.new(project_params)
		if @project.save
			redirect_to @project
		else
			render :new
		end
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

	def find_commentable
	  params.each do |name, value|
	    if name =~ /(.+)_id$/
	      return $1.classify.constantize.find(value)
	    end
	  end
	  nil
	end
end
