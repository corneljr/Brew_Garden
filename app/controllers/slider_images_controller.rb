class SliderImagesController < ApplicationController
	def create
		@slider_image = SliderImage.new(slider_image_params)
		@slider_image.save
	end

private

	def slider_image_params
		params.require(:slider_image).permit(:slider_image, :project_id)
	end
end
