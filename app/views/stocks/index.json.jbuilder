json.array!(@stocks) do |stock|
  json.extract! stock, :id, :product_id, :invoice_list_id, :purchase_list_id, :quantity, :price
  json.url stock_url(stock, format: :json)
end
