class OrderItem < ActiveRecord::Base
  belongs_to :product
  belongs_to :order

  validates :quantity, :product_id, :order_id, presence: true
  validates_numericality_of :quantity, :greater_than => 0
end
