json.array!(@products) do |product|
  json.extract! product, :id, :name, :price, :user_id, :photo_url, :stock, :description, :active
  json.url product_url(product, format: :json)
end
