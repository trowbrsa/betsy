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
    association :user
  end

  factory :order do

  end

  factory :review do
    rating 4
    association :product
  end

  factory :orderitem, class: OrderItem do
    quantity 4
    association :order
    association :product
  end

  factory :category do
    name "toy"
  end

end
