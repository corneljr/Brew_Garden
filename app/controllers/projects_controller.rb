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
			@projects.order('days_left ASC')
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
		@results = []

		@users = User.where("LOWER(name) LIKE LOWER(?)", "%#{@search}%")
		if @users.present?
			@users.each do |user|
				@results << user.projects.where(post_status: true)
			end
		end

		@results.push(@projects.where("LOWER(title) LIKE LOWER(?)", "%#{@search}%"))
		@results.push(@projects.where("LOWER(category) LIKE LOWER(?)", "%#{@search}%"))
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
		@twitter_reward = @project.twitter_reward
		@rewards = @project.rewards.order('amount asc')
		@commentable = find_commentable
  	@comments = @project.comments
  	@location = Geocoder.search(@project.location).first.city
  	@end_date = date_format(Date.today + @project.days_left.days)

  	if request.xhr?
  		render partial: 'show_info'
  	end
	end

	def new
		@project = Project.new
		@project.rewards.build
		@project.slider_images.build
		@twitter_reward = TwitterReward.new
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
		if @project.save
			@project.update_currency_for_save
			@project.update_video_link
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
		params.require(:project).permit(:title, :video_link, :description, :days_left, :image, :logo, :goal, :location, :category, :short_blurb, :tmsg, :hashtags, rewards_attributes: [:id, :amount, :description, :pledges_left, :_destroy, :shipping], slider_images_attributes: [:id, :slider_image], twitter_reward_attributes: [:id, :message, :hashtags])
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
