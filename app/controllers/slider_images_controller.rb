class SliderImagesController < ApplicationController
	def create
		@project = Project.find(params[:project_id])
		@slider_image = @project.slider_images.build(slider_image_params)
		@slider_image.save
	end

private

	def slider_image_params
		params.require(:slider_image).permit(:slider_image)
	end
end
