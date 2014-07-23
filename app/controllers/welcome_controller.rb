class WelcomeController < ApplicationController
  def index
  	# @total_funding = Project.all.sum(:funded_amount)
    @most_funded = Project.all.order('funded_amount DESC').limit(3)
    @projects = Project.all
    @geojson = Array.new

    @projects.each do |project|
  		@geojson << "{
		    type: 'Feature',
		    geometry: {
		      type: 'Point',
		      coordinates: [#{project.longitude}, #{project.latitude}]
		    },
		    properties: {
		      :'marker-color' => '#00607d',
		      :'marker-symbol' => 'beer',
		      :'marker-size' => 'medium'
		    }
		  }"
    end	

    respond_to do |format|
		  format.html
		  format.json { render json: @geojson }  # respond with the created JSON object
		end
  end
end
