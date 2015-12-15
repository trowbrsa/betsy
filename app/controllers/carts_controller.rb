class CartsController < ApplicationController

  def index
    if session[:cart]
      @cart = session[:cart]
    else
      @cart = {}
    end
  end

  def add
    product = Product.find(params[:id])
    product_id = params[:id]
    if session[:cart]
      cart = session[:cart]
    else
      session[:cart] = {}
      cart = session[:cart]
    end
    # if the cart already has the product -> just add one
    # if not -> set the quantity to one
    if cart[product_id]
      cart[product_id] = cart[product_id] + 1
    else
      cart[product_id] = 1
    end

    redirect_to cart_path
  end

  def clearCart
    session[:cart] = nil
    redirect_to index
  end

  def destroy
    cart = session[:cart]
    product_id = params[:id]
    cart.delete(product_id)
    redirect_to cart_path
  end

end
