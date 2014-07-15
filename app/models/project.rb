class Project < ActiveRecord::Base
	belongs_to :user
	has_many :rewards
	has_many :pledges, through: :rewards

	validates :title, :description, :goal, :end_date, presence: :true
	validate :end_date_in_the_future 

	accepts_nested_attributes_for :rewards

	def end_date_in_the_future
		if date < Date.today
			errors.add(:date, "Can't be in the past") 
		end
	end
end
