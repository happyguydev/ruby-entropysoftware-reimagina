require 's3'

$service = S3::Service.new(:access_key_id => ENV["AWS_KEY"], :secret_access_key => ENV["AWS_SECRET"])