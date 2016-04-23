json.array!(@rollbacks) do |rollback|
  json.extract! rollback, :id
  json.url rollback_url(rollback, format: :json)
end
