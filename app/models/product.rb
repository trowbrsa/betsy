class Product < ActiveRecord::Base
  belongs_to :user
  has_many :orders
  has_many :reviews
  has_and_belongs_to_many :categories

  validates :name, :price, presence: true
  validates :name, uniqueness: true
  validates_numericality_of :price, :greater_than => 0
  validates_numericality_of :stock, :greater_than_or_equal_to => 0
  validates :photo_url, format: {with: /\.(png|jpg)\Z/i}, allow_nil: true

  def review_average
    if reviews.any?
      total = reviews.inject(0) { |sum, review| sum + review.rating }
      return total * 1.0 / reviews.count
    else
      return 0
    end
  end

  def review_rounded
    return review_average.round
  end

end
