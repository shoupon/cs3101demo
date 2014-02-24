class Location
  include Mongoid::Document

  embedded_in :place, polymorphic: true
  
  field :coordinate, type: String
end
