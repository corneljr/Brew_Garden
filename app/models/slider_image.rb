class SliderImage < ActiveRecord::Base
	belongs_to :project
	mount_uploader :slider_image, SliderImagesUploader
end
