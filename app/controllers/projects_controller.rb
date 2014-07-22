class ProjectsController < ApplicationController

	before_action :load_project, only: [:show, :update, :destroy, :edit]
	before_filter :require_login, :only => [:new, :edit, :update, :destroy, :create]

	def index
		@request_location = request.location
		@most_funded = Project.all.order('funded_amount DESC').limit(3)
		@newest = Project.order('created_at DESC').limit(3)
		@near = if @request_location.city.length > 2
			@location = @request_location.city
			Project.near(@location, 20).limit(3)
		else
			@location = Geocoder.search("toronto").first.city
			Project.near(@location, 20).limit(3)
		end

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
  	@end_date = date_format(@project.end_date)
  	if request.xhr?
  		render partial: 'show_info'
  	end
	end

	def new
		@project = Project.new
		@project.rewards.build
	end

	def create
		@project = current_user.projects.build(project_params)
		if @project.save
			if params[:slider_images]
				params[:slider_images].each do |image|
					@project.slider_images.create(slider_image: image)
			end
			redirect_to @project
		else
			render :new
		end
	end

	def update
		if @project.update(project_params)
			if params[:slider_images]
				params[:slider_images].each do |image|
					@project.photos.create(slider_image: image)
				end
			end
			redirect_to @project
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
		@projects = Project.order('created_at DESC')
	end

	def newest_projects
		@projects = Project.order('funded_amount DESC')
	end

	def near_location
		@projects = Project.near(params[:q], 20)
		@location = Geocoder.search(params[:q])[0].data['formatted_address']
	end

	private

	def load_project
		@project = Project.find(params[:id])
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
		date.strftime("%A") + ", " + date.strftime("%b") + " " + date.strftime("%d") + " " + date.strftime("%Y")
	end
end
