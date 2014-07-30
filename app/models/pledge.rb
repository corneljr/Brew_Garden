class Pledge < ActiveRecord::Base
	belongs_to :user
	belongs_to :project
	belongs_to :reward
	belongs_to :twitter_reward
end
