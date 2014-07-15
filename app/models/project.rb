class Project < ActiveRecord::Base
	belongs_to :user
	has_many :rewards
	has_many :pledges, through: :rewards

	validates :title, :description, :goal, :end_date, presence: :true

	accepts_nested_attributes_for :rewards, reject_if: :all_blank, allow_destroy: :true
end
