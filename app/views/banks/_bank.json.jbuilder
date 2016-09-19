json.extract! bank, :id, :number, :type, :sum, :description, :date, :payer_id, :receiver_id, :invoice_id, :created_at, :updated_at
json.url bank_url(bank, format: :json)