require 'rails_helper'

RSpec.describe Category, type: :model do
  describe ".validates" do

    it { is_expected.to validate_presence_of(:name) }

    it "must have a unique name" do
      Category.create(name: "sunscreen")
      expect(Category.new(name: "sunscreen")).to_not be_valid
      expect(Category.new(name: "babied sunscreen")).to be_valid
    end

  end

end
