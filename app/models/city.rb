class City
  include Mongoid::Document

  belongs_to :country
  has_and_belongs_to_many :trips
  embeds_one :location
  has_many :attractions

  field :name, type: String
end
