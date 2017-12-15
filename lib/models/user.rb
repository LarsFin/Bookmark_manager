require 'data_mapper'
require 'dm-postgres-adapter'
require 'dm-migrations'
require 'dm-validations'
require 'bcrypt'

class User
  include DataMapper::Resource

  property :id, Serial
  property :email, String, required: true, unique: true, format: :email_address,
  :messages => {
    :presence => "We need your email address.",
    :is_unique => "We already have that email.",
    :format => "Doesn't look like an email address to me..."
  }
  property :password_digest, Text
  attr_accessor :password_confirmation
  attr_reader :password

  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end

  validates_confirmation_of :password
  # validates_length_of :email, :min => 3

end
