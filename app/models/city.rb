class City
  include Mongoid::Document

  embeds_one :location, as: :place
  belongs_to :country
  has_and_belongs_to_many :trips
  has_many :attractions
  has_many :photos

  field :name, type: String

  validates_presence_of :name
  validates_presence_of :location

  before_create :find_country
  def find_country
    country_name = Geocoder.search("#{location.latitude},#{location.longitude}").first.country
    c = Country.find_by(:name => country_name)
    unless c.nil?
      self.country = c
    else
      self.country = Country.new(:name => country_name)
      self.country.save
    end
  end
end
