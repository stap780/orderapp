desc "updateorder"
task :updateorder => :environment do


require 'nokogiri'
require 'open-uri'
require 'rest-client'


    @iorders = Iorder.order("number desc").limit(50)
    @iorders.each do |iorder|
    url = "http://worksys.myinsales.ru/admin/orders/#{(iorder.inid)}.xml"
    data = Nokogiri::XML(open(url, :http_basic_authentication => ['a75a0364d3cdd9f4de05bc69a5d17084' ,'15ec04dba5b5045675b8b3a80dcb1486']))
    
    status = data.xpath("order/fulfillment-status").text
    financial = data.xpath("order/financial-status").text
    payment = data.xpath("order/payment-title").text
    delivery = data.xpath("order/delivery-title").text 
    client = data.xpath("order/client/name").text
    client_middlename = data.xpath("order/client/middlename").text
    client_surname = data.xpath("order/client/surname").text
    phone = data.xpath("order/client/phone").text
    email = data.xpath("order/client/email").text
    total = data.xpath("order/total-price").text
    shipping_zip = data.xpath("order/shipping-address/zip").text
    shipping_city = data.xpath("order/shipping-address/city").text
    shipping_address = data.xpath("order/shipping-address/address").text     
    
    iorder.update_attributes(:status => status, :financial => financial, :payment => payment, :delivery => delivery, :client => client, :client_middlename => client_middlename, :client_surname => client_surname, :phone => phone, :email => email, :total => total, :shipping_zip => shipping_zip, :shipping_city => shipping_city, :shipping_address => shipping_address)
     
    end
    
end
