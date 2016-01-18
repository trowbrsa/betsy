class OrderItemsController < ApplicationController
  def index
    @user = User.find(params[:user_id])
    @orders = @user.orders
  end

  def shipped
    order_item = OrderItem.find(params[:id])
    if !order_item.shipped
      order_item.update(:shipped => true)
      Order.check_order_shipped(order_item)
    else
      order_item.update(:shipped => false)
      Order.check_order_shipped(order_item)
    end
    redirect_to :back
  end
end
