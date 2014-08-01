class Pledge < ActiveRecord::Base
	belongs_to :user
	belongs_to :project
	belongs_to :reward
	belongs_to :twitter_reward

	def unique_projects
		@projects = []
		self.each do |pledge|
			@projects.push(pledge.project)
		end
		@projects.uniq!
	end
end
