class User < ActiveRecord::Base
  
  has_many :friendships
  has_many :friends, through: :friendships
  has_many :slots
  
  has_secure_password validations: false
  
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :username, presence: true, uniqueness: true, length: {minimum: 3}
  validates :password, presence: true, on: :create, length: {minimum: 5}
  
end