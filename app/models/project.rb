class Project < ActiveRecord::Base
	scope :most_funded, -> { pledges.order('')}

	belongs_to :user
	has_many :rewards
	has_many :pledges, through: :rewards
	has_many :updates
	has_many :comments, :as => :commentable


	validates :title, :description, :goal, :end_date, presence: :true
	validates :goal, numericality: { only_integer: true }
	validate :date_check
	validates :title, length: { maximum: 125 }
	validates :short_blurb, length: { maximum: 200 }

	geocoded_by :get_location
	before_save :geocode

	accepts_nested_attributes_for :rewards, reject_if: :all_blank, allow_destroy: true

	mount_uploader :image, ImageUploader
	mount_uploader :slider_images, SliderImagesUploader

	def date_check 
		if end_date < Date.today
			errors.add(:end_date, "The date must be in the future you fool") 
		end
	end 

	def update_funded_amount
		self.funded_amount = self.pledges.sum(:amount)
	end

	def days_left
		days = self.end_date - Date.today
	end

	def get_location
		self.location
	end
end
