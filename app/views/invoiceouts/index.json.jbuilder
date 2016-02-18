json.array!(@invoiceouts) do |invoiceout|
  json.extract! invoiceout, :id, :number, :date, :company_id, :invoice_list_id, :total_price, :nds, :payment
  json.url invoiceout_url(invoiceout, format: :json)
end
