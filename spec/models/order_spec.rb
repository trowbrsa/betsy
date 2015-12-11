require 'rails_helper'

RSpec.describe Order, type: :model do
  let (:sample_order) {
    Order.create
  }

  describe ".validates" do
    
  end
end

# class Order < ActiveRecord::Base
#   has_many :order_items
#   validates_numericality_of :zip, :cc_num, allow_nil: true
#   validates_length_of :zip, is: 5, allow_nil: true
#   validates :email, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i }, allow_nil: true
# end

# create_table "orders", force: :cascade do |t|
#   t.string   "email"
#   t.string   "street"
#   t.string   "city"
#   t.string   "state"
#   t.string   "zip"
#   t.string   "cc_num"
#   t.date     "cc_exp"
#   t.integer  "cc_cvv"
#   t.string   "cc_name"
#   t.datetime "created_at", null: false
#   t.datetime "updated_at", null: false
# end
