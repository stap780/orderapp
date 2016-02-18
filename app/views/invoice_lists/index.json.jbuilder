json.array!(@invoice_lists) do |invoice_list|
  json.extract! invoice_list, :id, :number, :date, :status, :total_price, :client_id, :company_id
  json.url invoice_list_url(invoice_list, format: :json)
end
