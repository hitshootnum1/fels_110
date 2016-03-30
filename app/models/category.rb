class Category < ActiveRecord::Base
  has_many :lessons
  has_many :words

  mount_uploader :image, ImageUploader
end
