require "cloudinary"
require "shrine/storage/cloudinary"


Cloudinary.config(
  cloud_name: ENV['CLOUD_NAME'],
  api_key:ENV['API_KEY'],
  api_secret:ENV['API_SECRET'],
)



Shrine.storages = {
  cache: Shrine::Storage::Cloudinary.new(prefix: "cache"), # for direct uploads
  store: Shrine::Storage::Cloudinary.new(prefix: "store"),
}


# require "shrine"
# require "shrine/storage/file_system"
# # require "shrine/storage/s3"
#
# Shrine.plugin :activerecord
# Shrine.plugin :logging, logger: Rails.logger
#
# # s3_options = {
# #     access_key_id:      ENV['S3_KEY'],
# #     secret_access_key:  ENV['S3_SECRET'],
# #     region:             ENV['S3_REGION'],
# #     bucket:             ENV['S3_BUCKET']
# # }
#
# Shrine.storages = {
#   cache: Shrine::Storage::FileSystem.new("public", prefix: "uploads/cache"),
#   # cache: Shrine::Storage::S3.new(prefix: "cache", **s3_options),
#   store: Shrine::Storage::FileSystem.new("public", prefix: "uploads/store"),
#   # store: Shrine::Storage::S3.new(prefix: "store", **s3_options),
# }
