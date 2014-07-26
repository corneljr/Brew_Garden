class ProjectsController < ApplicationController
	before_action :load_posted_projects, only: [:index, :category, :search, :location_search, :near_location]
	before_action :load_project, only: [:show, :update, :destroy, :edit, :post]
	before_filter :require_login, only: [:new, :edit, :update, :destroy, :create]

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

		@projects = Project.all
		@geojson = Array.new
    @projects.each do |project|
  		@geojson << { type: 'Feature',
		    geometry: {
		      type: 'Point',
		      coordinates: [project.longitude, project.latitude]
		    },
		    properties: {
		      :'marker-color' => '#00607d',
		      :'marker-symbol' => 'beer',
		      :'marker-size' => 'medium'
		    }
		  }
		end

		respond_to do |format|
			format.html
			format.js
			format.json { render json: @geojson}
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

		@results = @projects.where("LOWER(title) LIKE LOWER(?)", "%#{@search}%")
		@results = @results.push(@projects.where("LOWER(category) LIKE LOWER(?)", "%#{@search}%"))
		@results = @results.flatten.uniq
		@location_results = @projects.near(@search, 30)

		@project_count = @results.count

		if @location_results.present?
			@location = Geocoder.search(@search).first.city
		end

		if @search.length == 0
			@results = @projects
			@search = 'all'
		end

		if request.xhr? && @location_results.present?
			render partial: 'project', collection: @location_results
		elsif request.xhr?
			render partial: 'project', collection: @results
		end
		
	end

	def show
		@rewards = @project.rewards
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
		@project = current_user.projects.build(project_params)
		if @project.save(validate: false)
			redirect_to edit_project_path(@project), notice: 'save successful'
		else
			redirect_to edit_project_path(@project), notice: 'error'
		end
	end

	def post
		@project.post_status = true
		@project.update_currency_for_save
		if @project.save
			redirect_to @project, notice: 'project posted'
		else
			render :edit
		end
	end 

	def update
		@project.assign_attributes(project_params)
		if @project.save(validate: false)
			redirect_to edit_project_path(@project), notice: 'save successful'
		else
			redirect_to edit_project_path(@project), notice: 'error'
		end
	end

	def destroy
		@project.destroy
	end

	def edit
		if current_user != @project.user
			redirect_to projects_path, alert: 'Whooaaaaaaaa, not your project bud.'
		end
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

	def past_projects
		@projects = Project.where(post_status: true).past_projects
	end

	private

	def load_project
		@project = Project.find(params[:id])
	end

	def load_posted_projects
		@projects = Project.where(post_status: true).current_projects
	end

	def project_params
		params.require(:project).permit(:title, :description, :end_date, :image, :goal, :slider_images, :location, :category, :short_blurb, rewards_attributes: [:id, :amount, :description, :pledges_left, :_destroy])
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
