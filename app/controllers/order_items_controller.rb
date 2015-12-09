class OrderItemsController < ApplicationController
  before_action :set_order_item, only: [:show, :edit, :update, :destroy]

  def index
    @user = User.find(params[:user_id])
    @order_items = OrderItem.all
  end

  def show
    @user = User.find(params[:user_id])
  end

  def new
    @order_item = OrderItem.new
    @user = User.find(params[:user_id])
  end

  def edit
    @user = User.find(params[:user_id])
  end

  def create
    @order_item = OrderItem.new(order_item_params)
      if @order_item.save
        redirect_to user_order_order_items_path
      else
        render "new"
      end
  end

  def update
     @order_item.update(order_item_params)
     redirect_to user_order_order_items_path
  end

  def destroy
    @order_item.destroy
    redirect_to user_order_order_items_path
  end

  private

    def set_order_item
      @order_item = OrderItem.find(params[:id])
    end

    def order_item_params
      params.require(:order_item).permit(:product_id, :order_id, :quantity)
    end
end
