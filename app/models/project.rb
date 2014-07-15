class Project < ActiveRecord::Base
	belongs_to :user
	has_many :rewards
	has_many :pledges, through: :rewards

	validates :title, :description, :goal, :end_date, presence: :true
	validate :date_check

	accepts_nested_attributes_for :rewards, reject_if: :all_blank, allow_destroy: true

	def date_check 
		if end_date < Date.today
			errors.add(:end_date, "The date must be in the future you fool") 
		end
	end 

end
