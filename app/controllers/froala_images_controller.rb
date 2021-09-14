class FroalaImagesController < ApplicationController
	load_and_authorize_resource
	
	def create
		respond_to do |format|
			@image = FroalaImage.where(key: froala_image_params[:key])

			if @image.empty?
				@image = FroalaImage.new(froala_image_params)
				@image.save
			else
				@image.update(froala_image_params)			
			end

			format.js {}	
		end
	end

	private
		def froala_image_params
      		params.require(:froala_image).permit(:key, :tag_list)
    	end
end