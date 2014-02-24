class Attraction
  include Mongoid::Document

  embeds_one :location
  belongs_to :city

  field :name, type: String
end
