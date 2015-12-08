json.array!(@reviews) do |review|
  json.extract! review, :id, :rating, :product_id, :description
  json.url review_url(review, format: :json)
end
