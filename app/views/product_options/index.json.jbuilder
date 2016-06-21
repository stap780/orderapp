json.array!(@product_options) do |product_option|
  json.extract! product_option, :id, :opt_value_inid, :opt_name_inid, :title
  json.url product_option_url(product_option, format: :json)
end
