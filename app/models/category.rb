class Category < ActiveRecord::Base
  has_many :lessons
  has_many :words

  mount_uploader :image, ImageUploader

  scope :name_like, ->name{where "name like ?", "%#{name}%"}
end
