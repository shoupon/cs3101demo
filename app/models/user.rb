require 'bcrypt'

class User
  include Mongoid::Document
  # users.password_hash in the database is a :string
  include BCrypt
  before_save :hash_password

  has_many :trips

  field :name, type: String
  field :email, type: String
  field :password, type: String
  field :password_confirmation, type: String
  field :password_hash, type: String
  field :nickname, type: String
  field :role, type: Symbol, default: :traveler 
  # :traveler: typical user, :admin: administrator
  
  has_and_belongs_to_many :visit_cities, class_name: "City", inverse_of: :visitors
  has_and_belongs_to_many :visit_countries, class_name: "Country", inverse_of: :visitors

  mount_uploader :avatar, AvatarUploader

  validates_presence_of :email
  validates_uniqueness_of :email
  validates_presence_of :password, unless: :hash_exist
  validates_length_of :password, minimum: 8, maximum: 16, unless: :hash_exist
  validates_confirmation_of :password, unless: :hash_exist
  validate :check_password, unless: :hash_exist

  def hash_password
    self.password_hash = BCrypt::Password.create(self.password)
    self.password = ''
    self.password_confirmation = ''
  end

  def check_password
    if self.password.to_s[' ']
      errors.add(:password, "can't contain blank(s)")
      return false
    else
      return true
    end
  end

  def hash_exist
    unless self.password_hash.nil?
      return true
    else
      return false
    end
  end
end
