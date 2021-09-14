class S3Controller < ApplicationController
	load_and_authorize_resource
	
	def index
		@gallery = []
		@bucket = $service.buckets.find(ENV["S3_BUCKET"])
		@objects = @bucket.objects
		@objects.map { |o|  
			image = Hash.new
			image["url"] =  "https://s3.amazonaws.com/reimagina-develop/#{o.key}"
			image["thumb"] =  "https://s3.amazonaws.com/reimagina-develop/#{o.key}"
			image['tag'] = FroalaImage.find_by(key: o.key).nil? ? '' : FroalaImage.find_by(key: o.key).tag_list.join(', ')
			@gallery << image
		}

		respond_to do |format|
			format.json { render json: @gallery, status: :ok }
		end
	end
end

# if o.content_type.match("^image?/(?:jpg|gif|png)")
# 	logger.info o.inspect
# end