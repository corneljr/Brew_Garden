class WelcomeController < ApplicationController
  def index
  	# @total_funding = Project.all.sum(:funded_amount)
    @most_funded = Project.all.order('funded_amount DESC').limit(3)
  end
end
