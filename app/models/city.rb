class City
  include Mongoid::Document
  field :name, type: String
  field :locate, type: Location
end
