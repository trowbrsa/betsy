class Review < ActiveRecord::Base
  belongs_to :product

  validates :rating, presence: true
  validates :rating, numericality: { :greater_than => 0, less_than: 6 }


  def self.find_user_id(review)
    product = Product.find(review.product_id)
    return User.find(product.user_id)
  end

end
