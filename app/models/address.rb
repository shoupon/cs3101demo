class Address < Location
  include Mongoid::Document
  field :street_1, type: String
  field :street_2, type: String
  field :city, type: String
  field :state, type: String
  field :zip_code, type: String
end
