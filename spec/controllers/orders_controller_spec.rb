require 'rails_helper'

RSpec.describe OrdersController, type: :controller do
  let (:sample_user) {
    User.create(username: "Kelly", email: "Kelly@kelly.com", password: "password")
  }

  let (:good_params) {
    { user_id: sample_user.id,
      order: { email: "Kelly@kelly.com", street: "test" , city: "Seattle", state: "WA", zip: "98116", cc_num: "123", cc_cvv: "123", cc_name: "Kelly", cc_exp: "20151215"}
    }
  }

  let (:bad_params) {
    { user_id: sample_user.id,
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
      sample_order = Order.create(good_params[:order])
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
    it "redirects to checkout confirmation page" do
      session[:cart] = { 1 => 2, 3 => 4 }
      session[:user_id] = sample_user.id
      post :create, good_params
      expect(subject).to redirect_to confirmation_path(Order.all.last)
    end

    it "renders new template on error" do
      session[:cart] = { 1 => 2, 3 => 4 }
      post :create, bad_params
      expect(subject).to render_template :new
    end
  end
end
