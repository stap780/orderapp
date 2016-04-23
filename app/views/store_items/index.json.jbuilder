json.array!(@store_items) do |store_item|
  json.extract! store_item, :id, :loss_id, :enter_id, :product_id, :quantity, :title, :price, :sum
  json.url store_item_url(store_item, format: :json)
end
