class Reward < ActiveRecord::Base
	belongs_to :project
	has_many :pledges

	validates :pledges_left, numericality: { only_integer: true }
	
	def add_backer
    self.pledges_left -= 1
  end

  def update_currency_for_save
		self.amount *= 100
	end

	def update_currency_for_display
		self.amount /= 100
	end
	
end
