class Trip
  include Mongoid::Document

  belongs_to :user
  has_and_belongs_to_many :cities
  has_many :photos
  accepts_nested_attributes_for :photos, :allow_destroy => true
  
  field :start, type: Date
  field :end, type: Date

  before_validation :find_cities
  def find_cities
    photos.each do |p|
      unless p.latitude.nil? || p.longitude.nil?
        geo = Geocoder.search("#{p.location.latitude},#{p.location.longitude}").first
        c = City.find_by(name: geo.city)
        unless c.nil?
          c.photos << p
          unless cities.include? c 
            cities << c
          end
          c.save!
        else
          c = City.new(name: geo.city)
          citycoord = Geocoder.coordinates(geo.city)
          c.location = Location.new(latitude: citycoord[0], longitude: citycoord[1])
          c.photos << p
          c.save!
          cities << c
        end
      end
    end
  end
end
