require 'rails_helper'

RSpec.describe Review, type: :model do
  let(:sample_product) {
    Product.create(name: "Water bottle", price: 10 )
  }
end
