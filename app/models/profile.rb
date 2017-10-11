class Profile < ApplicationRecord
  include ImageUploader[:image]
  belongs_to :user
  has_many :photo
end
