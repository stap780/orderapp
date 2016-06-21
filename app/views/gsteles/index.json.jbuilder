json.array!(@gsteles) do |gstele|
  json.extract! gstele, :id, :sku, :title, :quantity, :valute, :cost_price, :price
  json.url gstele_url(gstele, format: :json)
end
