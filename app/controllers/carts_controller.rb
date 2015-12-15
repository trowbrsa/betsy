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
      #check that the product is on stock
      if product.stock >= cart[product_id] + 1
        cart[product_id] = cart[product_id] + 1
        redirect_to cart_path
      else
        flash[:error] = "The product is not on stock"
        redirect_to user_product_path(product.user_id, product.id)
      end
    else
      cart[product_id] = 1
      redirect_to cart_path
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
    redirect_to cart_path
  end

end
