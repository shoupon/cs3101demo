class Trip
  include Mongoid::Document

  belongs_to :user
  
  field :start, type: Date
  field :end, type: Date
end
