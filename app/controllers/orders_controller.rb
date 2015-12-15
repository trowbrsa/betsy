class OrdersController < ApplicationController
  before_action :require_login, only: [:index]
  before_action :correct_user, only: [:index]
  before_action :order_items, only: [:new, :create]
  before_action :find_user

  def index
    @orders = @user.orders
  end

  def show
    @order = Order.find(params[:id])
  end

  def new
    @order = Order.new
  end

  def create
    @order = Order.new(order_params)
    @order_items.each do |oi|
      oi.save
      @order.order_items << oi
    end
    if @order.save
      redirect_to user_orders_path
    else
      render :new
    end
  end

  private

  def order_items
    session[:cart] = { 3 => 2, 5 => 4 }
    @order_items = []
    session[:cart].each do |product, quantity|
      @order_items.push(OrderItem.new(:product_id => product, :quantity => quantity))
    end
  end

  def find_user
    @user = User.find(params[:user_id])
  end

  def order_params
    params.require(:order).permit(:email, :street, :city, :state, :zip, :cc_num, :cc_exp, :cc_cvv, :cc_name)
  end
end
