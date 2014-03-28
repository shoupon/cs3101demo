# encoding: utf-8
require 'carrierwave/processing/mini_magick'

class ImageUploader < CarrierWave::Uploader::Base

  # Include RMagick or MiniMagick support:
  # include CarrierWave::RMagick
  include CarrierWave::MiniMagick

  # Choose what kind of storage to use for this uploader:
  #storage :file
  storage :grid_fs
  # storage :fog

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  # Provide a default URL as a default if there hasn't been a file uploaded:
  def default_url
    # For Rails 3.1+ asset pipeline compatibility:
    ActionController::Base.helpers.asset_path("fallback/" + [version_name, "default.png"].compact.join('_'))
 
  #   "/images/fallback/" + [version_name, "default.png"].compact.join('_')
  end

  # Process files as they are uploaded:
  # process :scale => [200, 300]
  #
  # def scale(width, height)
  #   # do something
  # end

  process :extract_geolocation
  # source code:
  # http://hasmanyfollows.com/2011/06/03/extracting-geolocation-image-data-with-carrierwave-and-rmagick-on-heroku/
  def extract_geolocation
    puts '11111111111'
    img = Magick::Image.read(@image.image)[0] rescue nil
 
    puts '22222222222'
    return unless img
    img_lat = img.get_exif_by_entry('GPSLatitude')[0][1].split(', ') rescue nil
    img_lng = img.get_exif_by_entry('GPSLongitude')[0][1].split(', ') rescue nil
 
    lat_ref = img.get_exif_by_entry('GPSLatitudeRef')[0][1] rescue nil
    lng_ref = img.get_exif_by_entry('GPSLongitudeRef')[0][1] rescue nil
 
    puts '333333333333'
    return unless img_lat && img_lng && lat_ref && lng_ref
 
    latitude = to_frac(img_lat[0]) + (to_frac(img_lat[1])/60) + (to_frac(img_lat[2])/3600)
    longitude = to_frac(img_lng[0]) + (to_frac(img_lng[1])/60) + (to_frac(img_lng[2])/3600)
 
    latitude = latitude * -1 if lat_ref == 'S'  # (N is +, S is -)
    longitude = longitude * -1 if lng_ref == 'W'   # (W is -, E is +)
 
    puts '444444444444'
    self.latitude = latitude.to_s
    self.longitude = longitude.to_s
    self.location = Location.new(:latitude => latitude, :longitude => longitude)
  end

  # Create different versions of your uploaded files:
  version :medium do
    process :resize_to_limit => [200, 200]
  end

  version :large do
    process :resize_to_limit => [400, 400]
  end

  # Add a white list of extensions which are allowed to be uploaded.
  # For images you might use something like this:
  # def extension_white_list
  #   %w(jpg jpeg gif png)
  # end

  # Override the filename of the uploaded files:
  # Avoid using model.id or version_name here, see uploader/store.rb for details.
  # def filename
  #   "something.jpg" if original_filename
  # end

end
