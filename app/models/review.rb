class Review < ActiveRecord::Base
  belongs_to :product

  validates :rating, presence: true
  validates :rating, numericality: { :greater_than => 0, less_than: 6 }
end
