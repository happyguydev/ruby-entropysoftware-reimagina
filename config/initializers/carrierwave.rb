CarrierWave.configure do |config|
  config.fog_provider = 'fog/aws'                        # required
  config.fog_credentials = {
    provider:              'AWS',                        # required
    aws_access_key_id:     ENV["AWS_KEY"],                       # required
    aws_secret_access_key: ENV["AWS_SECRET"],                        # required
    region:                ENV["AWS_REGION"]                 # optional, defaults to 'us-east-1'
    # host:                  's3.example.com'             # optional, defaults to nil
    # endpoint:              '' # optional, defaults to nil
  }
  config.fog_directory  = ENV["S3_BUCKET"]                         # required
  config.fog_public     = false                                        # optional, defaults to true
  config.fog_attributes = { cache_control: "public, max-age=#{365.day.to_i}" } # optional, defaults to {}
end