# json.array!(@iorders) do |iorder|
#   json.extract! iorder, :id, :number, :iml_id, :dpd_id, :post_id, :courier_id
#   #json.url iorder_url(iorder, format: :json)
# end

json.array! @iorders do |iorder|
  json.number iorder.number
  if iorder.iml_id.present?
	json.courierName 'IML'	  
  json.track iorder.iml.barcode if iorder.iml !=nil
  json.status iorder.iml.state if iorder.iml !=nil
  else
  if iorder.dpd_id.present?
	json.courierName 'DPD'	  
  json.track iorder.dpd.dpdnumber
  json.status iorder.dpd.state
  else
  json.courierName 'not available'	  
  json.track 'not available'
  json.status 'not available'
  end
  end
  
end