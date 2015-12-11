require 'rails_helper'

RSpec.describe Product, type: :model do
  let(:sample_product) {
    Product.create(name: "Water bottle", price: 10 )
  }
  describe ".validates" do
    it "must have a name and price" do
      expect(Product.new(name: "a")).to_not be_valid
      expect(Product.new(price: 15)).to_not be_valid
      expect(Product.new(name: "a", price: 15)).to be_valid
    end
    it "must have a unique name" do
      expect(Product.new(name: "Water bottle")).to_not be_valid
    end
    it "must have a numerical price" do
      expect(Product.new(name: "a", price: "a")).to_not be_valid
    end
    it "must have a price greater than 0" do
      expect(Product.new(name: "a", price: -1)).to_not be_valid
      expect(Product.new(name: "a", price: 0)).to_not be_valid
    end
    it "must have an image url ending in jpg or png" do
      sample_product.photo_url = "image.jpg"
      expect(sample_product).to be_valid
      sample_product.photo_url = "https://upload.wikimedia.org/wikipedia/commons/4/47/PNG_transparency_demonstration_1.png"
      expect(sample_product).to be_valid
      sample_product.photo_url = "image.mov"
      expect(sample_product).to_not be_valid
      sample_product.photo_url = "https://upload.wikimedia.org/wikipedia/commons/4/47/PNG_transparency_demonstration_1"
      expect(sample_product).to_not be_valid
    end
  end
  describe "review methods" do
    let(:r1) {
      Review.create(rating: 3)
    }
    let(:r2) {
      Review.create(rating: 4)
    }
    it "calculates the correct review statistics" do
      sample_product.reviews = [r1, r2]
      expect(sample_product.review_average).to eq(3.5)
      expect(sample_product.review_rounded).to eq(4)
    end
    it "returns 0 for no reviews" do
      expect(sample_product.review_average).to eq(0)
      expect(sample_product.review_average).to eq(0)
    end
  end

end
