class City
  include Mongoid::Document

  belongs_to :country
  embeds_one :location

  field :name, type: String
end
