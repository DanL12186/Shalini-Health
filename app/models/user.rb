class User < ApplicationRecord
  has_secure_password

  has_many :appointments

  validates :first_name, :last_name, :email, :password, presence: true
  validates :email, uniqueness: true
  validates :password, length: { minimum: 8 }
  
end