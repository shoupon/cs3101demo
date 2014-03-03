class Violation
    include Mongoid::Document
    
    field :summon_number, type: String
    field :plate, type: String
    field :state, type: String
    field :vehicle_type, type: String
    field :issue_date, type: String
    field :violation_description, type: String
    field :violation_code, type: String
    field :fine,  type: Fixnum
    field :county, type: String
    field :addr_number, type: String
    field :addr_street, type: String
end