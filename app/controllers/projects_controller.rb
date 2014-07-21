class ProjectsController < ApplicationController

	before_action :load_project, only: [:show, :update, :destroy, :edit]
	before_filter :require_login, :only => [:new, :edit, :update, :destroy, :create]

	def index
		#@location = request.location
		#@near = Project.near(location, 20).limit(3)

		@most_funded = Project.all.order('funded_amount DESC').limit(3)
		@newest = Project.order('created_at DESC').limit(3)
		@location = 'Toronto'
		@near = Project.near(@location, 20).limit(3)

		respond_to do |format|
			format.html
			format.js
		end
	end

	def category
		@category = params[:category]
		@projects = if @category && @category != 'all'
			Project.where(category: @category)
		else
			Project.all
		end
	end

	def search
		@search = params[:q]
		@projects = if @search
			Project.where("LOWER(title) LIKE LOWER(?)", "%#{params[:q]}%")
		else
			@search = 'all'
			Project.all
		end
	end

	def show
		@rewards = @project.rewards
		@days_left = ((@project.end_date - Time.now)/(60 * 60 * 24)).round
		@commentable = find_commentable
  	@comments = @project.comments

  	if request.xhr?
  		render partial: 'show_info'
  	end
	end

	def new
		@project = Project.new
		@project.rewards.build
	end

	def create
		@project = Project.new(project_params)
		@project.user = current_user
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
		@project = Project.find(params[:project_id])
		@pledges = @project.pledges

		if request.xhr?
			render partial: 'backer'
		end
	end

	def location_search
		@near = Project.near(params[:q], 50).limit(3)
		@location = Geocoder.search(params[:q])[0].data['formatted_address']
		unless @near.present? 
			@near = Project.near('Toronto', 50).limit(3)
			@location = 'Toronto'
		end

		if request.xhr?
			render partial: 'project', collection: @near
		end
	end

	def most_funded
	end

	def newest_projects
	end

	def near_location
	end

	private

	def load_project
		@project = Project.find(params[:id])
	end

	def project_params
		params.require(:project).permit(:title, :description, :end_date, :goal, :image, rewards_attributes: [:amount, :description, :pledges_left, :_destroy])
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
