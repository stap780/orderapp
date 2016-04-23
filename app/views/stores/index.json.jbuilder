json.array!(@stores) do |store|
  json.extract! store, :id, :product_id, :quantity, :price
  json.url store_url(store, format: :json)
end
