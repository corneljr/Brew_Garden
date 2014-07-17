class Project < ActiveRecord::Base
	scope :most_funded, -> { pledges.order('')}

	belongs_to :user
	has_many :rewards
	has_many :pledges, through: :rewards
	has_many :updates
	has_many :comments, :as => :commentable


	validates :title, :description, :goal, :end_date, presence: :true
	validate :date_check

	geocoded_by :get_location
	before_save :geocode

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
