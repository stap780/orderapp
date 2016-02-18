json.array!(@invoices) do |invoice|
  json.extract! invoice, :id, :number, :date, :client_id, :company_id, :companytwo, :invstatus, :discount, :total_price
  json.url invoice_url(invoice, format: :json)
end
