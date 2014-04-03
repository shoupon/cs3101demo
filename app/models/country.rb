class Country
  include Mongoid::Document

  has_many :cities
  has_and_belongs_to_many :visitors, class_name: "User", inverse_of: :visit_countries

  field :name, type: String

  validates_presence_of :name
end
