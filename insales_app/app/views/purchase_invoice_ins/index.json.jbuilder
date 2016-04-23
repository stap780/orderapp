json.array!(@purchase_invoice_ins) do |purchase_invoice_in|
  json.extract! purchase_invoice_in, :id, :number, :data, :purchase_list_id
  json.url purchase_invoice_in_url(purchase_invoice_in, format: :json)
end
