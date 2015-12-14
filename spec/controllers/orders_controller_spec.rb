require 'rails_helper'

RSpec.describe OrdersController, type: :controller do
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
      get :index
      expect(response.status).to eq 200
    end
  end

  describe "GET 'show'" do
    it "renders the show view" do
      get :show, id: sample_order.id
      expect(subject).to render_template :show
    end
  end

  describe "GET 'new'" do
    it "renders new view" do
      get :new
      expect(subject).to render_template :new
    end
  end

  describe "POST 'create'" do
    it "redirects to index page" do
      post :create
      expect(subject).to redirect_to orders_path
    end

    it "renders new template on error" do
      post :create, bad_params
      expect(subject).to render_template :new
    end
  end

  describe "GET 'edit'" do
    it "renders edit view" do
      get :edit, id: sample_order.id
      expect(subject).to render_template :edit
    end
  end

  describe "PATCH 'update'" do
    it "redirects to index page" do
      patch :update, { order: { zip: "02780" } }
      expect(subject).to redirect_to orders_path
      expect(Order.all.last.zip).to eq "02780"
    end

    it "renders edit template on error" do
      patch :update, bad_params
      expect(subject).to render_template :edit
      expect(Order.all.last.zip).to eq nil
    end
  end

  describe "DELETE 'destroy'" do
    it "redirects to index page" do
      delete :destroy, id: sample_order.id
      expect(subject).to redirect_to orders_path
    end
  end
end
