class ReviewsController < ApplicationController
  before_action :find_review, only: [:show, :edit, :update, :destroy]
  before_action :find_product, only: [:new, :edit]

  def index
    @reviews = Review.all
    @product = Product.find(params[:product_id])
  end


  def show
  end

  def new
    @review = Review.new
  end


  def edit
  end


  def create
    review = Review.create(review_params) do |r|
      r.product_id = params[:product_id]
    end
    redirect_to user_product_reviews_path(review.product.user, review.product, review)
  end


  def update
    @review.update(review_params)
    redirect_to user_product_reviews_path(@review.product.user, @review.product, @review)
  end


  def destroy
    @review.destroy
    redirect_to user_product_reviews_path(@review.product.user, @review.product, @review)
  end

  private

    def review_params
      params.require(:review).permit(:rating, :description)
    end

    def find_review
      @review = Review.find(params[:id])
    end

    def find_product
      @product = Product.find(params[:product_id])
    end
end
