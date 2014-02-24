class Trip
  include Mongoid::Document

  belongs_to :user
  has_and_belongs_to_many :cities
  
  field :start, type: Date
  field :end, type: Date
end
