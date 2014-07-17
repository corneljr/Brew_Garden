class ProjectsController < ApplicationController

	before_action :load_project, only: [:show, :update, :destroy, :edit, :backers]

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
		@project.update(project_params)
		@project.save
		redirect_to @project
	end

	def destroy
		@project.destroy
	end

	def edit
		@rewards = @project.rewards
	end

	def backers
		@pledges = @project.pledges
	end

	private

	def load_project
		@project = Project.find(params[:id])
	end
	
	def project_params
		params.require(:project).permit(:title, :description, :end_date, :goal, :image, rewards_attributes: [:amount, :description, :_destroy])
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
