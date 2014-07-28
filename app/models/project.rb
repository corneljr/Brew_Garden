class Project < ActiveRecord::Base
	scope :most_funded, -> { pledges.order('') }
	scope :current_projects, -> { where("days_left > ?", 0) }
	scope :past_projects, -> { where("days_left == ?", 0) }


	belongs_to :user
	has_many :rewards, dependent: :destroy
	has_many :pledges
	has_many :updates
	has_many :comments, :as => :commentable
	has_many :slider_images, dependent: :destroy



	validates :title, :description, :goal, :end_date, presence: true
	validates :goal, numericality: { only_integer: true }
	validates :title, length: { maximum: 125 }
	validates :short_blurb, length: { maximum: 200 }, presence: true
	validates :video_link, format: { with: /youtube/, message: 'must be uploaded to youtube'}


	geocoded_by :get_location
	before_save :geocode

	accepts_nested_attributes_for :slider_images, allow_destroy: true
	accepts_nested_attributes_for :rewards, reject_if: proc { |attributes| attributes["amount"].blank? || attributes["description"].blank? }, allow_destroy: true

	def update_funded_amount
		amount = 0
		self.pledges.each do |pledge|
			amount += pledge.reward.amount
		end
		self.funded_amount = amount
	end

	def get_location
		self.location
	end

	def update_currency_for_save
		self.goal *= 100

		self.rewards.each do |reward|
			reward.amount *= 100
		end
		self.save
	end

	def update_video_link
		if self.video_link
			split_link = self.video_link.split('watch')
			link = split_link.join('embed/watch')
			self.video_link = link
			self.save
		end
	end
end
