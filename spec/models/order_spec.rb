require 'rails_helper'

RSpec.describe Order, type: :model do
  let (:good_params) {
    {street: "test" , city: "Seattle", state: "WA", zip: "98116", cc_num: "12345678", cc_cvv: "123", cc_name: "Kelly", cc_exp: "20151215"}
  }

  describe ".validates" do
    it { is_expected.to validate_length_of(:zip) }
    it { is_expected.to validate_presence_of(:email) }
    it { is_expected.to validate_presence_of(:street) }
    it { is_expected.to validate_presence_of(:city) }
    it { is_expected.to validate_presence_of(:state) }
    it { is_expected.to validate_presence_of(:zip) }
    it { is_expected.to validate_presence_of(:cc_num) }
    it { is_expected.to validate_presence_of(:cc_exp) }
    it { is_expected.to validate_presence_of(:cc_cvv) }
    it { is_expected.to validate_presence_of(:cc_name) }

    it "must have a valid email " do
      expect(Order.create(good_params.merge(email: "user_at_foo.org"))).to_not be_valid
      expect(Order.create(good_params.merge(email: "example.user@foo."))).to_not be_valid
      expect(Order.create(good_params.merge(email: "foo@bar_baz.com"))).to_not be_valid
      expect(Order.create(good_params.merge(email: "foo@bar+baz.com"))).to_not be_valid
      expect(Order.create(good_params.merge(email: " "))).to_not be_valid
      expect(Order.create(good_params.merge(email: "kelly@kelly.com"))).to be_valid
    end
  end

  describe ".total_cost" do
    let(:order_item) { FactoryGirl.create(:orderitem) }
    it "calculates the total for an order" do
      order = order_item.order
      item_price = order_item.product.price
      quantity = order_item.quantity
      total = order.total_cost
      expect(total).to eq item_price * quantity
    end
  end
end
