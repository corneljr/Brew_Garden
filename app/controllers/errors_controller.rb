class ErrorsController < ApplicationController

	def catch_404
		raise ActionController::RoutingError.new('Page Not Found')
	end
end
