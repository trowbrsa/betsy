class Order < ActiveRecord::Base
  has_many :order_items
  has_many :products, through: :order_items
  validates :email, :street, :city, :state, :zip, :cc_num, :cc_exp, :cc_cvv, :cc_name, presence: true
  validates_numericality_of :zip, :cc_num, allow_nil: true
  validates_length_of :zip, is: 5, allow_nil: true
  validates :email, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i }, allow_nil: true

  def total_cost(user = nil)
    total = 0
    order_items = self.order_items
    if !(user.nil?)
      order_items_for_total = []
      order_items.each do |oi|
        order_items_for_total.push(oi) if oi.product.user == user
      end
      order_items = order_items_for_total
    end
    order_items.each do |oi|
      total += (oi.product.price * oi.quantity)
    end
    return total
  end

  def self.check_order_shipped(order_item)
    order = Order.find(order_item.order_id)
    if order[:status] != "shipped"
      count = 0
      order.order_items.each do |order_item|
        count += 1 if order_item.shipped
      end
      if count == order.order_items.count
        order.update(:status => "shipped")
      end
    else
      order.update(:status => "paid")
    end
  end

  def self.filter_orders(orders, status)
    filtered_orders = []
    orders.each do |order|
      filtered_orders.push(order) if Order.find(order.id).status.downcase == status.downcase
    end
    return filtered_orders
  end
end
