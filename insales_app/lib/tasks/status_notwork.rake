desc "Status update"
task :status_update => :environment do


require 'nokogiri'
require 'open-uri'
require 'rest-client'

    @iorders = Iorder.find_all_by_number
    @iorders.each do |iorder|
    url = "http://worksys.myinsales.ru/admin/orders.xml"
    data = Nokogiri::XML(open(url, :http_basic_authentication => ['a75a0364d3cdd9f4de05bc69a5d17084' ,'15ec04dba5b5045675b8b3a80dcb1486']))
    
    number == data.xpath("orders/order/number").text
    
    status = data.xpath("orders/order/fulfillment-status").text 
    
    iorder.update_attribute(:status, status) 
    end
	#financial = data.xpath("orders/order/financial-status").text,
	#payment = data.xpath("orders/order/payment-title").text,
	#delivery = data.xpath("orders/order/delivery-title").text,
	#client = data.xpath("orders/order/client/name").text,
	#phone = data.xpath("orders/order/client/phone").text,
	#email = data.xpath("orders/order/client/email").text,
	#total = data.xpath("orders/order/total-price").text
	

	#Iorder.where("number = #{:number}").update_all(:status, status)
	
	
end