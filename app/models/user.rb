require 'bcrypt'
class User < ActiveRecord::Base
  has_secure_password
  # devise :database_authenticatable, :registerable,
  #          :recoverable, :rememberable, :trackable, :validatable
end