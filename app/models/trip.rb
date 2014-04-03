class Trip
  include Mongoid::Document

  belongs_to :user
  has_and_belongs_to_many :cities
  has_and_belongs_to_many :countries
  has_many :photos
  accepts_nested_attributes_for :photos, :allow_destroy => true
  
  field :start, type: Date
  field :end, type: Date

  before_validation :find_cities
  before_create :visit_cities_and_countries
  def find_cities
    photos.each do |p|
      unless p.city.nil?
        self.cities << p.city
        self.countries << p.city.country
      end
    end
  end

  def visit_cities_and_countries
    self.cities.each do |city|
      unless user.visit_cities.include?(city)
        user.visit_cities << city
      end
    end

    self.countries.each do |country|
      unless user.visit_countries.include?(country)
        user.visit_countries << country
      end
    end
  end
end
