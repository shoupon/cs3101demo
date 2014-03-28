class Location
  include Mongoid::Document

  embedded_in :place, polymorphic: true
  
  field :latitude, type: String
  field :longitude, type: String

  validates_presence_of :latitude
  validates_presence_of :longitude
end
