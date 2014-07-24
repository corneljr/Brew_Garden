class ProjectsController < ApplicationController

	before_action :load_posted_projects, only: [:index, :category, :search, :location_search, :near_location]
	before_action :load_project, only: [:show, :update, :destroy, :edit, :post]
	before_filter :require_login, :only => [:new, :edit, :update, :destroy, :create]

	def index
		@request_location = request.location
		@most_funded = @projects.order('funded_amount DESC').limit(3)
		@newest = @projects.order('created_at DESC').limit(3)
		@near = if @request_location.city.length > 2
			@location = @request_location.city
			@projects.near(@location, 20).limit(3)
		else
			@location = Geocoder.search("toronto").first.city
			@projects.near(@location, 20).limit(3)
		end

		respond_to do |format|
			format.html
			format.js
		end
	end

	def category
		@category = params[:category]

		@projects = if @category == 'Staff Picks'
			@projects.sample(9)
		elsif @category == 'Most Funded'
			@projects.order('funded_amount DESC')
		elsif @category == 'Recently Launched'
			@projects.order('created_at DESC')
		elsif @category == 'Ending Soon'
			@projects.order('created_at ASC')
		elsif @category && @category != 'all'
			@projects.where(category: @category)
		else
			@projects
		end

		@project_count = @projects.count

		if request.xhr?
			render partial: 'project', collection: @projects
		end
	end

	def search
		@search = params[:q]
		@projects = if @search
			@projects.where("LOWER(title) LIKE LOWER(?)", "%#{params[:q]}%")
		else
			@search = 'all'
			@projects
		end
	end

	def show
		@rewards = @project.rewards
		@days_left = ((@project.end_date - Time.now)/(60 * 60 * 24)).round
		@commentable = find_commentable
  	@comments = @project.comments
  	@end_date = date_format(@project.end_date)
  	if request.xhr?
  		render partial: 'show_info'
  	end
	end

	def new
		@project = Project.new
		@project.rewards.build
		@project.slider_images.build
	end

	def create
		@project = current_user.projects.create(project_params)
		redirect_to edit_project_path(@project)
	end

	def post
		@project.post_status = true
		binding.pry
		redirect_to @project
	end

	def update
		if @project.update(project_params)
			redirect_to edit_project_path(@project)
		else
			render :edit
		end
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
		@near = @projects.near(params[:q], 50).limit(3)
		@location = Geocoder.search(params[:q])[0].data['formatted_address']
		unless @near.present? 
			@near = @projects.near('Toronto', 50).limit(3)
			@location = 'Toronto'
		end

		if request.xhr?
			render partial: 'project', collection: @near
		end
	end

	def near_location
		@projects = @projects.near(params[:q], 20)
		@location = Geocoder.search(params[:q])[0].data['formatted_address']
	end

	private

	def load_project
		@project = Project.find(params[:id])
	end

	def load_posted_projects
		@projects = Project.where(post_status: true)
	end

	def project_params
		params.require(:project).permit(:title, :description, :end_date, :goal, :image, :slider_images, :location, :category, :short_blurb, rewards_attributes: [:amount, :description, :pledges_left, :_destroy])
	end

	def find_commentable
	  params.each do |name, value|
	    if name =~ /(.+)_id$/
	      return $1.classify.constantize.find(value)
	    end
	  end
	  nil
	end

	def date_format(date)
		date.strftime("%A, %b %d %Y")
	end
end
