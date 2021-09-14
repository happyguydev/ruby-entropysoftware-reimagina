class ErrorsController < ApplicationController
	load_and_authorize_resource
	
	def show
		render action: request.path[1..-1]
	end
end
