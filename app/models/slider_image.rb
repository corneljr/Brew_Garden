class SliderImage < ActiveRecord::Base
	belongs_to :project
	mount_uploader :slider_image, SliderImagesUploader
	validates :slider_image, presence: true
end
