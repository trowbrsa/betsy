class ReviewsController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  def index
    @reviews = Review.all
    @product = Product.find(params[:product_id])
  end


  def show
    @review = Review.find(params[:id])
  end

  def new
    @review = Review.new
  end


  def edit
  end


  def create
    @review = Review.new(review_params)

    respond_to do |format|
      if @review.save
        format.html { redirect_to @review, notice: 'Review was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end


  def update
    respond_to do |format|
      if @review.update(review_params)
        format.html { redirect_to @review, notice: 'Review was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end


  def destroy
    @review.destroy
    respond_to do |format|
      format.html { redirect_to reviews_url, notice: 'Review was successfully destroyed.' }
    end
  end

  private

    def set_review
      @review = Review.find(params[:id])
    end

    def review_params
      params.require(:review).permit(:rating, :description)
    end

    def set_user
      set_review
      product = Product.find(@review.product_id)
      @user = User.find(product.user_id)
    end
end
