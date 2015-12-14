require 'rails_helper'

RSpec.describe ProductsController, type: :controller do
  let (:sample_user) {
    User.create(username: "Kelly", email: "Kelly@kelly.com", password: "password")
  }

  let (:sample_product) {
    Product.create(name: "Rubber ducky",  price: "500", stock: "1", user_id: sample_user.id)
  }

  let (:bad_params) {
    { user_id: sample_user.id,
      product: { price: "zzz" }
    }
  }

  let (:sample_category_1) {
    Category.create(name: "Pool toys")
  }

  let (:sample_category_2) {
    Category.create(name: "Fun in the sun")
  }

  let (:good_params) {
    { user_id: sample_user.id, categories: [sample_category_1.id, sample_category_2.id], product: { name: "Loofah",  price: "600", stock: "2", photo_url: "hi.jpg" } }
  }

  describe "GET 'index'" do
    it "is successful" do
      get :index
      expect(response.status).to eq 200
    end
  end

  describe "GET 'show'" do
    it "renders the show view" do
      get :show, id: sample_product.id, user_id: sample_product.user_id
      expect(subject).to render_template :show
    end
  end

  describe "GET 'new'" do
    it "renders new view" do
      get :new, user_id: sample_user.id
      expect(subject).to render_template :new
    end
  end

  describe "POST 'create'" do
    it "redirects to users's products page" do
      post :create, good_params
      expect(subject).to redirect_to user_products_path(Product.all.last.user_id)
    end

    it "renders new template on error" do
      post :create, bad_params
      expect(subject).to render_template :new
    end
  end

  describe "GET 'edit'" do
    it "renders edit view" do
      get :edit, id: sample_product.id, user_id: sample_product.user_id
      expect(subject).to render_template :edit
    end
  end

  describe "PATCH 'update'" do
    it "redirects to users's products page" do
      patch :update, good_params.merge({id: sample_product.id})
      expect(subject).to redirect_to user_products_path(sample_product.user)
      expect(Product.all.last.name).to eq "Loofah"
    end

    it "renders edit template on error" do
      patch :update, bad_params.merge({id: sample_product.id})
      expect(subject).to render_template :edit
      expect(Product.all.last.name).to eq "Rubber ducky"
    end
  end
end
