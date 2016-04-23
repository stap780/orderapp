json.array!(@enters) do |enter|
  json.extract! enter, :id, :number, :date, :description, :total
  json.url enter_url(enter, format: :json)
end
