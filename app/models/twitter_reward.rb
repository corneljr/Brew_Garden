class TwitterReward < ActiveRecord::Base
	has_many :pledges
	belongs_to :project

	def update_hashtags
		self.hashtags.gsub(" ", "") if self.hashtags
	end

	def encode_message
		URI.encode(self.message) if self.message
	end
end
