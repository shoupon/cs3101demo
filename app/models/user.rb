require 'bcrypt'

class User
  include Mongoid::Document
  # users.password_hash in the database is a :string
  include BCrypt

  has_many :trips

  field :name, type: String
  field :email, type: String
  field :password, type: String

  # virtual attribute, not sure if this works
  def password_input
  end
  
  def password_confirm
  end
end