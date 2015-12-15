require 'rails_helper'

RSpec.describe OrdersController, type: :controller do
  let (:sample_user) {
    User.create(username: "Kelly", email: "Kelly@kelly.com", password: "password")
  }

  let (:sample_product) {
    Product.create(name: "Rubber ducky",  price: "500", stock: "1", user_id: sample_user.id)
  }

  let (:sample_order_item) {
    User.create(product_id: sample_product.id, order_id: sample_order.id, quantity: "3")
  }

  let (:sample_order) {
    Order.create
  }

  let (:bad_params) {
    {
      order: { zip: "zzz" }
    }
  }

  describe "GET 'index'" do
    it "is successful" do
      session[:user_id] = sample_user.id
      get :index, user_id: sample_user.id
      expect(response.status).to eq 200
    end
  end

  describe "GET 'show'" do
    it "renders the show view" do
      get :show, id: sample_order.id, user_id: sample_user.id
      expect(subject).to render_template :show
    end
  end

  describe "GET 'new'" do
    it "renders new view" do
      session[:cart] = { 1 => 2, 3 => 4 }
      get :new, user_id: sample_user.id
      expect(subject).to render_template :new
    end
  end

  describe "POST 'create'" do
    it "redirects to index page" do
      session[:cart] = { 1 => 2, 3 => 4 }
      post :create, { user_id: sample_user.id } 
      expect(subject).to redirect_to orders_path
    end

    it "renders new template on error" do
      post :create, bad_params
      expect(subject).to render_template :new
    end
  end

  # describe "GET 'edit'" do
  #   it "renders edit view" do
  #     get :edit, id: sample_order.id
  #     expect(subject).to render_template :edit
  #   end
  # end

  # describe "PATCH 'update'" do
  #   it "redirects to index page" do
  #     patch :update, { order: { zip: "02780" } }
  #     expect(subject).to redirect_to orders_path
  #     expect(Order.all.last.zip).to eq "02780"
  #   end
  #
  #   it "renders edit template on error" do
  #     patch :update, bad_params
  #     expect(subject).to render_template :edit
  #     expect(Order.all.last.zip).to eq nil
  #   end
  # end

  # describe "DELETE 'destroy'" do
  #   it "redirects to index page" do
  #     delete :destroy, id: sample_order.id
  #     expect(subject).to redirect_to orders_path
  #   end
  # end
end
