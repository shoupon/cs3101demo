class Trip
  include Mongoid::Document

  belongs_to :user
  has_and_belongs_to_many :cities
  has_many :photos
  accepts_nested_attributes_for :photos
  
  field :start, type: Date
  field :end, type: Date
end
