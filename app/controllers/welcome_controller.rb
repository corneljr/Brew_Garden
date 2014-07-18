class WelcomeController < ApplicationController
  def index
  	@total_funding = Project.all.sum(:funded_amount)
  end
end
