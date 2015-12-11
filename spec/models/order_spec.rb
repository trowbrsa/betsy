require 'rails_helper'

RSpec.describe Order, type: :model do
  describe ".validates" do
    it { is_expected.to validate_numericality_of(:zip) }
    it { is_expected.to validate_numericality_of(:cc_num) }
    it { is_expected.to validate_length_of(:zip) }

    it "must have a nil or valid email " do
      expect(Order.create(email: 'user@foo,com')).to_not be_valid
      expect(Order.create(email: 'user_at_foo.org')).to_not be_valid
      expect(Order.create(email: 'example.user@foo.')).to_not be_valid
      expect(Order.create(email: 'foo@bar_baz.com')).to_not be_valid
      expect(Order.create(email: 'foo@bar+baz.com')).to_not be_valid
      expect(Order.create(email: ' ')).to_not be_valid
      expect(Order.create(email: 'kelly@kelly.com')).to be_valid
      expect(Order.create(email: nil)).to be_valid
    end
  end
end
