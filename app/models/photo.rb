class Photo
  include Mongoid::Document

  mount_uploader :image, ImageUploader
  belongs_to :trip
end