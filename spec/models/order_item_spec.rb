require 'rails_helper'

RSpec.describe OrderItem, type: :model do
  describe ".validates" do
    it { is_expected.to validate_presence_of(:quantity) }
    # don't need to validate numericality since it is an integer

    it "requires a quantity in correct range" do
      expect(OrderItem.new(quantity: 5)).to be_valid
      expect(OrderItem.new(quantity: 0)).to be_invalid
      expect(OrderItem.new(quantity: -1)).to be_invalid
    end
  end
end
