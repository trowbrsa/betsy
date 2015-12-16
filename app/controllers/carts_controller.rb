class CartsController < ApplicationController

  def index
    @cart = session[:cart]
  end

  def add
    product = Product.find(params[:id])
    product_id = params[:id]
    session[:cart] = {} if !session[:cart]
    cart = session[:cart]
    if cart[product_id].nil? && product.stock > 0 # adding product for the first time
      cart[product_id] = 1
      redirect_to cart_path
    elsif cart[product_id] && product.stock >= cart[product_id] + 1 # adding product already in cart
      cart[product_id] += 1
      redirect_to cart_path
    else
      flash[:error] = "Sorry, there is not enough product in stock to fulfill your request."
      redirect_to user_product_path(product.user_id, product.id)
    end
  end

  def clearCart
    session[:cart] = nil
    redirect_to index
  end

  def destroy
    cart = session[:cart]
    product_id = params[:id]
    cart.delete(product_id)
    session[:cart] = nil if session[:cart] == {}
    redirect_to cart_path
  end
end
