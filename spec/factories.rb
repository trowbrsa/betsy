FactoryGirl.define do
  factory :user do
    username "foo"
    email { "#{username}@example.com" }
    password "foobar"
    password_confirmation "foobar"
  end

  factory :product do
    name "Water Noodle"
    price 500
    stock 10
  end

  factory :order do

  end

  factory :review do
    rating 4
    association :product, :factory => :product, :user_id => 1
  end

  factory :orderitem do

  end

  factory :category do
    name "toy"
    product
  end

end
