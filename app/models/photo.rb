class Photo < ApplicationRecord
  include ImageUploader[:image]
  belongs_to :user
  # belongs_to :profile
  has_many :comments
  acts_as_votable

end
