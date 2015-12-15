class CategoriesController < ApplicationController
  before_action :find_category, only: [:show, :edit, :update]

  def index
    @categories = Category.all
    @category = Category.new
  end


  def show
    @products = @category.products.paginate(page: params[:page], per_page: 12)
  end

  #
  # def new
  #   @category = Category.new
  # end


  def edit
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      redirect_to categories_path
    else
      @categories = Category.all
      render :index
    end
  end

  def update
    if @category.update(category_params)
      redirect_to categories_path
    else
      render :edit
    end
  end

  private

  def find_category
    @category = Category.find(params[:id])
  end

  def category_params
    params.require(:category).permit(:name)
  end
end
