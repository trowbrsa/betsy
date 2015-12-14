require 'rails_helper'

RSpec.describe User, type: :model do
  let (:user) { FactoryGirl.create(:user) }
  it { is_expected.to have_secure_password }

  describe ".validates" do
    it { is_expected.to validate_presence_of(:email) }

    it "must have a unique email" do
      expect(User.new(name: "Nemo", username: "Nemo1", email: user.email, password: "123", password_confirmation: "123")).to_not be_valid
    end

    it "downcases email before checking validity" do
      expect(User.new(name: "Nemo", username: "Nemo1", email: user.email.upcase, password: "123", password_confirmation: "123")).to_not be_valid
    end

    it "must have a valid email" do
      expect(User.new(email: 'nemo@foo,com', name: "Bob", username: "bobi", password: "333", password_confirmation: "333")).to_not be_valid
      expect(User.new(email: 'nemo_at_foo.org', name: "Bob", username: "bobi", password: "333", password_confirmation: "333")).to_not be_valid
      expect(User.new(email: 'nemo.user@foo.', name: "Bob", username: "bobi", password: "333", password_confirmation: "333")).to_not be_valid
      expect(User.new(email: 'nemo@bar_baz.com', name: "Bob", username: "bobi", password: "333", password_confirmation: "333")).to_not be_valid
      expect(User.new(email: 'nemo@bar+baz.com', name: "Bob", username: "bobi", password: "333", password_confirmation: "333")).to_not be_valid
      expect(User.new(email: ' ', name: "Bob", username: "bobi", password: "333", password_confirmation: "333")).to_not be_valid
      expect(User.new(email: 'nemo@nemo.com', name: "Bob", username: "bobi", password: "333", password_confirmation: "333")).to be_valid
    end

  end


end
