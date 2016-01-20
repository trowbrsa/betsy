class OrdersController < ApplicationController
  before_action :require_login, only: [:index]
  before_action :correct_user, only: [:index]
  before_action :order_items, only: [:new, :create]
  before_action :find_user, except: [:new, :create, :confirm, :cancel]

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

  def calculateshipping
    results = HTTParty.get("http://wetsy-ship.herokuapp.com/ship?destination%5Bcity%5D=Seattle&destination%5Bcountry%5D=US&destination%5Bstate%5D=WA&destination%5Bzip%5D=98103&origin%5Bcity%5D=Beverly+Hills&origin%5Bcountry%5D=US&origin%5Bstate%5D=CA&origin%5Bzip%5D=90210&packages%5B%5D%5Bheight%5D=50&packages%5B%5D%5Blength%5D=20&packages%5B%5D%5Bweight%5D=100&packages%5B%5D%5Bwidth%5D=30"
    # headers: {"Authorization" => "bearer #{carrier_access_token}", 'Accept' => 'application/json' }, format: :json).parsed_response

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
