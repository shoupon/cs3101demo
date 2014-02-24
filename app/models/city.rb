class City
  include Mongoid::Document

  belongs_to :country
  has_and_belongs_to_many :trips

  field :name, type: String
end
