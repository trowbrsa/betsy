class User < ActiveRecord::Base
  has_many :products
  has_secure_password
end
