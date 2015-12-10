class User < ActiveRecord::Base
  has_many :products
  has_secure_password

  before_save { self.email = email.downcase } # ensures emails are all lowercase

  validates :username, :email, presence: true
  validates :username, :email, uniqueness: true
  validates :email, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i }

end
