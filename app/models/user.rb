class User < ActiveRecord::Base
  has_many :products
  has_many :order_items, through: :products
  has_many :orders, through: :order_items
  has_secure_password

  before_validation { self.email = email.downcase if self.email } # ensures emails are all lowercase

  validates :username, :email, presence: true
  validates :username, :email, uniqueness: true
  validates :email, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i }

  def average_rating
    return 0 if products.count == 0
    total_rating = 0.0
    total_reviews = 0
    products.each do |product|
      total_rating += product.review_total
      total_reviews += product.reviews.count
    end
    total_reviews == 0 ? (return 0) : (return total_rating / total_reviews)
  end
end
