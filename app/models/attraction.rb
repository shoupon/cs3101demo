class Attraction
  include Mongoid::Document

  embeds_one :location, as: :place
  belongs_to :city

  field :name, type: String
end
