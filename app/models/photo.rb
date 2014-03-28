class Photo
  include Mongoid::Document
  include CarrierWave::RMagick

  mount_uploader :image, ImageUploader
  
  belongs_to :trip
  belongs_to :city
  embeds_one :location, as: :place
  field :latitude, type: String
  field :longitude, type: String
  field :description, type: String
  field :date, type: Date

  before_validation :extract_geolocation
 
  # source code:
  # http://hasmanyfollows.com/2011/06/03/extracting-geolocation-image-data-with-carrierwave-and-rmagick-on-heroku/
  def extract_geolocation
    img = Magick::Image.read(self.image.current_path)[0] rescue nil
    return unless img
    img_lat = img.get_exif_by_entry('GPSLatitude')[0][1].split(', ') rescue nil
    img_lng = img.get_exif_by_entry('GPSLongitude')[0][1].split(', ') rescue nil
 
    lat_ref = img.get_exif_by_entry('GPSLatitudeRef')[0][1] rescue nil
    lng_ref = img.get_exif_by_entry('GPSLongitudeRef')[0][1] rescue nil
 
    return unless img_lat && img_lng && lat_ref && lng_ref
 
    latitude = to_frac(img_lat[0]) + (to_frac(img_lat[1])/60) + (to_frac(img_lat[2])/3600)
    longitude = to_frac(img_lng[0]) + (to_frac(img_lng[1])/60) + (to_frac(img_lng[2])/3600)
 
    latitude = latitude * -1 if lat_ref == 'S'  # (N is +, S is -)
    longitude = longitude * -1 if lng_ref == 'W'   # (W is -, E is +)
 
    self.location = Location.new(:latitude => latitude, :longitude => longitude)
  end
 
  def to_frac(strng)
    numerator, denominator = strng.split('/').map(&:to_f)
    denominator ||= 1
    numerator/denominator
  end

end