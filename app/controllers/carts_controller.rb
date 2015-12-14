class CartsController < ApplicationController

  def show
  end

  def add_product
    quantity = params[:quantity]
    product_id = params[:product_id]
    add_product(product_id, quantity)
    redirect_to product_path(product_id)
  end

end
