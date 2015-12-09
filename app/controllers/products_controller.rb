class ProductsController < ApplicationController
  before_action :set_product, only: [:show, :edit, :update, :destroy]

  def index
    @products = Product.all
  end


  def show
  end


  def new
    @product = Product.new
  end

  def edit
  end

  def create
    @product = Product.new(product_params)
      if @product.save
        format.html { redirect_to @product, notice: 'Product was successfully created.' }
      else
        format.html { render :new }
      end
  end

  def update
    if @product.update(product_params)
      format.html { redirect_to @product, notice: 'Product was successfully updated.' }
    end
  end

  def destroy
    @product.destroy
    respond_to do |format|
      format.html { redirect_to user_products_path, notice: 'Product was successfully destroyed.' }
    end
  end

  private

    def set_product
      @product = Product.find(params[:id])
    end

    def product_params
      params.require(:product).permit(:name, :price, :user_id, :photo_url, :stock, :description, :active)
    end
end
