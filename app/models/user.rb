class User < ActiveRecord::Base
  has_many :products
  has_secure_password

  validates :username, :email, presence: true
  validates :username, :email, uniqueness: true
end
