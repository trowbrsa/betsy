class Order < ActiveRecord::Base
  has_many :order_items
  validates_numericality_of :zip, :cc_num, allow_nil: true
  validates_length_of :zip, is: 5, allow_nil: true
  validates :email, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i }, allow_nil: true
end
