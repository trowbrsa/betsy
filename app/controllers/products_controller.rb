class ProductsController < ApplicationController
  before_action :set_product, only: [:show, :edit, :update, :destroy]

  def index
    @products = Product.all.paginate(page: params[:page], per_page: 12)
  end


  def show
  end


  def new
    @product = Product.new
    @user = User.find(params[:user_id])
  end

  def edit
    @user = @product.user
  end

  def create
    @user = User.find(params[:user_id])
    @product = Product.create(product_params) do |p|
      p.user_id = @user.id
    end
    if @product.save
      redirect_to user_products_path(@product.user)
    else
      render :new
    end
  end

  def update
    @product.update(product_params)
    @user = @product.user
    if @product.save
      redirect_to user_products_path(@product.user)
    else
      render :edit
    end
  end

  private

    def set_product
      @product = Product.find(params[:id])
    end

    def product_params
      params.require(:product).permit(:name, :price, :photo_url, :stock, :description, :active)
    end
end
