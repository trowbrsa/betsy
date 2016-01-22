class OrdersController < ApplicationController
  before_action :require_login, only: [:index]
  before_action :correct_user, only: [:index]
  before_action :order_items, only: [:new, :create]
  before_action :find_user, except: [:new, :addshippinginfo, :checkout, :create, :confirm, :cancel]
  BASE_URL = "https://sea-merchant.herokuapp.com/ship?"


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
    # should put some/most of this code in the model, I know :(
    @order = Order.new

    destination = {
      city:     params[:order][:city],
      state:    params[:order][:state].upcase,
      zip:      params[:order][:zip],
      country:  "US"
    }

    packages_by_merchant = {}
    order_items.each do |product_id, quantity|
      product = Product.find(product_id)
      merchant_id = User.find(product.user_id).id
      if packages_by_merchant[merchant_id].nil?
        packages_by_merchant[merchant_id] = []
      end
      quantity.times do
        packages_by_merchant[merchant_id].push(
          {
            weight: product.weight,
            length: product.length,
            height: product.height,
            width:  product.width
          }
        )
      end
    end

    api_responses = []
    packages_by_merchant.each do |merchant_id, packages|
      merchant = User.find(merchant_id)
      origin = {
        city:     merchant.city,
        state:    merchant.state,
        zip:      merchant.zip,
        country:  "US"
      }

      api_params = {origin: origin, destination: destination, packages: packages}
      query = api_params.to_query
      results = HTTParty.get("#{BASE_URL + query}")
      api_responses.push(results)
    end
    @results = api_responses
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
