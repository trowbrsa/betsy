class WelcomeController < ApplicationController
  def index
    @products = Product.limit(12)
  end
end
