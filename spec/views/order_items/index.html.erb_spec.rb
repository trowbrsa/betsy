# require 'rails_helper'
#
# RSpec.describe "order_items/index", type: :view do
#   before(:each) do
#     assign(:order_items, [
#       OrderItem.create!(
#         :product_id => 1,
#         :order_id => 2,
#         :quantity => 3
#       ),
#       OrderItem.create!(
#         :product_id => 1,
#         :order_id => 2,
#         :quantity => 3
#       )
#     ])
#   end
#
#   it "renders a list of order_items" do
#     render
#     assert_select "tr>td", :text => 1.to_s, :count => 2
#     assert_select "tr>td", :text => 2.to_s, :count => 2
#     assert_select "tr>td", :text => 3.to_s, :count => 2
#   end
# end
