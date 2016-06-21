json.array!(@variants) do |variant|
  json.extract! variant, :id, :product_id, :variant_inid, :sku, :cost_price, :price, :old_price, :quantity, :weight
  json.url variant_url(variant, format: :json)
end
