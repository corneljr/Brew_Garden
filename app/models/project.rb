class Project < ActiveRecord::Base
	scope :most_funded, -> { pledges.order('')}

	belongs_to :user
	has_many :rewards
	has_many :pledges, through: :rewards
	has_many :updates
	has_many :comments, :as => :commentable
	has_many :slider_images


	with_options if: 'post_status' do |project|
		project.validates :title, :description, :goal, :end_date, presence: :true
		project.validates :goal, numericality: { only_integer: true }
		project.validate :date_check
		project.validates :title, length: { maximum: 125 }
		project.validates :short_blurb, length: { maximum: 200 }
	end

	geocoded_by :get_location
	before_save :geocode

	accepts_nested_attributes_for :slider_images, allow_destroy: true
	accepts_nested_attributes_for :rewards, reject_if: :all_blank, allow_destroy: true


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
