
json.extract! mycase, :id, :number, :client_id, :iorder_id, :status, :service, :description, :iorder_check, :created_at, :updated_at
json.url case_url(mycase, format: :json)