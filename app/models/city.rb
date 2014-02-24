class City
  include Mongoid::Document

  embeds_one :location, as: :place
  belongs_to :country
  has_and_belongs_to_many :trips
  has_many :attractions

  field :name, type: String
end
