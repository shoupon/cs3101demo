class Trip
  include Mongoid::Document

  belongs_to :user
  has_many :cities

  field :start, type: Date
  field :end, type: Date
end
