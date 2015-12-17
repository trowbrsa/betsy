class OrdersController < ApplicationController
  before_action :require_login, only: [:index]
  before_action :correct_user, only: [:index]
  before_action :order_items, only: [:new, :create]
  before_action :find_user, except: [:new, :create, :confirm, :cancel]

  def index
    @orders = @user.orders.uniq.sort
    if !(params["Status"].nil? || params["Status"] == "") # if the "Status" params is populated
      @orders = Order.filter_orders(@orders, params["Status"])
    end
  end

  def show
    @order = Order.find(params[:id])
  end

  def new
    not_enough_stock = false
    @order_items.each do |oi|
      not_enough_stock = true if oi.product.stock < oi.quantity
    end
    if not_enough_stock
      flash[:error] = "There is not enough stock to complete your purchase. Please update your cart."
      redirect_to cart_path
    else
      @order = Order.new
    end
  end


  def cancel
    order = Order.find(params[:id])
    order.update(:status => "cancelled")
    Product.increment_stock(order)
    flash[:error] = "Your order has been cancelled"
    redirect_to root_path
  end

  def create
    @order = Order.new(order_params)
    products_sold = []
    @order_items.each do |oi|
      @order.order_items << oi
      products_sold.push([oi.product, oi.quantity])
      oi.save
    end
    if @order.save
      Product.decrement_stock(products_sold)
      session[:cart] = nil
      redirect_to confirmation_path(@order)
    else
      render :new
    end
  end


  def confirm
    @order = Order.find(params[:order_id])
    @total = @order.total_cost
  end

  private

  def order_items
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
