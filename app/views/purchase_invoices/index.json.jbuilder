json.array!(@purchase_invoices) do |purchase_invoice|
  json.extract! purchase_invoice, :id, :number, :date, :company_id, :total_price
  json.url purchase_invoice_url(purchase_invoice, format: :json)
end
