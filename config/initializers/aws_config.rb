AWS_CONFIG = {
  'access_key_id' => ENV["AWS_KEY"],
  'secret_access_key' => ENV["AWS_SECRET"],
  'bucket' => ENV["S3_BUCKET"],
  'acl' => 'public-read',
  'key_start' => 'uploads/'
}