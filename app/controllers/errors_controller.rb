class ErrorsController < ApplicationController

	def catch_404
		redirect_to projects_path
	end
end
