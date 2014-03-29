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
  field :password_comfirmation, type: String
  field :nickname, type: String

  mount_uploader :avatar, AvatarUploader

  validates_presence_of :email
  validates_uniqueness_of :email
  validates_presence_of :password
  validates_length_of :password, minimum: 8, maximum: 16
  validates_confirmation_of :password
  validate :check_password

  def hash_password
    self.password = BCrypt::Password.create(self.password)
    self.password_comfirmation = ''
  end

  def check_password
    if self.password.to_s[' ']
      errors.add(:password, "can't contain blank(s)")
    end
  end
end