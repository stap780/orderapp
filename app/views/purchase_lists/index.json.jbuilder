json.array!(@purchase_lists) do |purchase_list|
  json.extract! purchase_list, :id, :number, :date, :company_id, :total_price
  json.url purchase_list_url(purchase_list, format: :json)
end
