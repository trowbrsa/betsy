class OrdersController < ApplicationController
  before_action :require_login, only: [:index]
  before_action :correct_user, only: [:index]
  before_action :order_items, only: [:new, :create]
  before_action :find_user, except: [:new, :addshippinginfo, :checkout, :create, :confirm, :cancel]

  def index
    orders = @user.orders
    @orders = orders.uniq.sort
    @paid_orders = Order.filter_orders(@orders, "paid")
    @completed_orders = Order.filter_orders(@orders, "shipped")
    @cancelled_orders = Order.filter_orders(@orders, "cancelled")
    @paid_orders_revenue = Order.user_orders_revenue(@paid_orders, @user)
    @completed_orders_revenue = Order.user_orders_revenue(@completed_orders, @user)
    @total_revenue = @paid_orders_revenue + @completed_orders_revenue
    if params["Status"].present?
      @orders = Order.filter_orders(@orders, params["Status"])
    end
  end

  def show
    @order = Order.find(params[:id])
  end

  def new
    not_enough_stock = false
    @order_items.each do |oi|
      not_enough_stock = true if Product.find(oi.product_id).stock < oi.quantity
    end
    if not_enough_stock
      flash[:error] = "There is not enough stock to complete your purchase. Please update your cart."
      redirect_to cart_path
    else
      @order = Order.new
      render :new
    end
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
      session[:order_id] = @order.id
      redirect_to confirmation_path
    else
      render :new
    end
  end

  def confirm
    if session[:order_id].nil?
      flash[:error] = "This page has expired."
      redirect_to root_path
    else
      @order = Order.find(session[:order_id])
      @total = @order.total_cost
    end
  end

  def checkout

    @order = Order.new
    order_items

    destination = {
    city: params[:order][:city],
    state: params[:order][:state],
    zip: params[:order][:zip],
    country: "US"
    }

    products = order_items.keys


    origin = {
    city: Product.find(products[0]).user.city,
    state: Product.find(products[0]).user.state,
    zip: Product.find(products[0]).user.zip,
    country: "US"
    }

    packages = [
      {
        weight: Product.find(products[0]).weight,
        length: Product.find(products[0]).length,
        height: Product.find(products[0]).height,
        width:  Product.find(products[0]).width
      }
    ]

    api_information = {origin: origin, destination: destination, packages: packages}

    query = api_information.to_query

    results = HTTParty.get("http://localhost:3001/ship?#{query}")

    raise

  end

  def cancel
    order = Order.find(params[:id])
    order.update(:status => "cancelled")
    Product.increment_stock(order)
    flash[:error] = "Your order has been cancelled"
    redirect_to root_path
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
