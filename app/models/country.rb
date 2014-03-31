class Country
  include Mongoid::Document

  has_many :cities

  field :name, type: String

  validates_presence_of :name
end
