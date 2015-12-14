require 'rails_helper'


RSpec.describe User, type: :model do

    let(:user1) {
      User.create(name: "Nemo", username: "Nemo1", email: "nemo@gmail.com", password: "123", password_confirmation: "123")
    }

  describe ".validates" do
    it { is_expected.to validate_presence_of(:email) }

    it "must have a unique email" do
      User.create(name: "Bob", username: "bobi", email: "nemo@gmail.com", password: "333", password_confirmation: "333")
      expect(User.new(name: "Nemo", username: "Nemo1", email: "nemo@gmail.com", password: "123", password_confirmation: "123")).to_not be_valid
    end

    it "must have a valid email " do
      expect(User.create(email: 'nemo@foo,com', name: "Bob", username: "bobi", password: "333", password_confirmation: "333")).to_not be_valid
      expect(User.create(email: 'nemo_at_foo.org', name: "Bob", username: "bobi", password: "333", password_confirmation: "333")).to_not be_valid
      expect(User.create(email: 'nemo.user@foo.', name: "Bob", username: "bobi", password: "333", password_confirmation: "333")).to_not be_valid
      expect(User.create(email: 'nemo@bar_baz.com', name: "Bob", username: "bobi", password: "333", password_confirmation: "333")).to_not be_valid
      expect(User.create(email: 'nemo@bar+baz.com', name: "Bob", username: "bobi", password: "333", password_confirmation: "333")).to_not be_valid
      expect(User.create(email: ' ', name: "Bob", username: "bobi", password: "333", password_confirmation: "333")).to_not be_valid
      expect(User.create(email: 'nemo@nemo.com', name: "Bob", username: "bobi", password: "333", password_confirmation: "333")).to be_valid
    end

  end


end
