require 'rails_helper'

RSpec.describe CartsController, type: :controller do


  describe "GET 'index'" do
    it "is successful" do
      get :index
      expect(response.status).to eq 200
    end
  end

  # describe "#destroy" do
  #   it "remove the product from the cart" do
  #     let :cart do
  #        { 1 => 6, 2 => 1, 5 => 3 }
  #     end
  #     let(:session[:cart] = cart)
  #     before :each do
  #       get "/delete", {}, { :cart => { :product_id => 2 }} # the first hash is params, second is session
  #     end
  #
  #     it "remove the product from the cart" do
  #       session[:cart][:product_id].should be_nil
  #     end
  #
  #   end
  # end

end
