json.extract! @purchase_invoice, :id, :number, :date, :company_id, :total_price, :created_at, :updated_at
json.product @purchase_invoice.purchase_invoice_items, :title, :quantity, :price