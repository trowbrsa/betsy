require 'rails_helper'


RSpec.describe User, type: :model do
  describe ".validates" do
    let(:user1) do
      User.create(name: "Nemo", username: "Nemo1", email: "nemo@gmail.com", password: "123", password_confirmation: "123")
    end
    let(:user2) do
      User.create(name: "Nemo2", username: "Nemo2", email: "nemo@gmail.com", password: "123", password_confirmation: "123")
    end
    it "must have a username" do
      expect(User.new(username: nil)).to_not be_valid
    end

    it "must have an email" do
      expect(User.new(email: nil)).to_not be_valid
    end
  end
  #
  describe "uniqueness" do
    it do
      should validate_uniqueness_of(:email)
    end
  end

  # it "should have uniqueness email" do
  #   expect validate_uniqueness_of(:email)
  # end
  #   it "should have uniqueness email" do
  #     expect(:user2).to be_vaild
  #   end
  # end
  #
  #
  # it { validate_uniqueness_of(:email) }
  # end

end
