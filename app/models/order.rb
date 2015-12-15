class Order < ActiveRecord::Base
  has_many :order_items
  has_many :products, through: :order_items
  validates :email, :street, :city, :state, :zip, :cc_num, :cc_exp, :cc_cvv, :cc_name, presence: true
  validates_numericality_of :zip, :cc_num, allow_nil: true
  validates_length_of :zip, is: 5, allow_nil: true
  validates :email, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i }, allow_nil: true

  def total_cost
    total = 0
    self.order_items.each do |oi|
      total += (oi.product.price * oi.quantity)
    end
    return total
  end
end
