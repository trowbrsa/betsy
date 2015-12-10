class ProductsController < ApplicationController
  before_action :find_product, only: [:show, :edit, :update, :destroy]
  before_action :find_user, only: [:new, :edit, :create, :update]

  def index
    @products = Product.all.paginate(page: params[:page], per_page: 12)
  end


  def show
  end


  def new
    @product = Product.new
  end

  def edit
  end

  def create
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
    if @product.save
      redirect_to user_products_path(@product.user)
    else
      render :edit
    end
  end

  private

    def find_product
      @product = Product.find(params[:id])
    end

    def find_user
      @user = User.find(params[:user_id])
    end

    def product_params
      params.require(:product).permit(:name, :price, :photo_url, :stock, :description, :active)
    end
end
