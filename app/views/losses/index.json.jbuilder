json.array!(@losses) do |loss|
  json.extract! loss, :id, :number, :date, :description, :total
  json.url loss_url(loss, format: :json)
end
