#namespace :iorder do
  desc "fetch insales orders"
  task :scrape => :environment do
    
    require 'open-uri'
    require 'nokogiri'
    require 'rest-client'
    
    
    url = "http://worksys.myinsales.ru/admin/orders.xml"
    data = Nokogiri::XML(open(url, :http_basic_authentication => ['a75a0364d3cdd9f4de05bc69a5d17084' ,'15ec04dba5b5045675b8b3a80dcb1486']))
    #order = "orders/order" #определение категории в файле в переменную
    
    #myio = data.xpath(order) # определение пути в переменную
    data.each do |io|
    #myio.each do |io| # создание хэша из данных заказа и запись их в переменные по каждому заказу 
    @iorder = Iorder.new
    @iorder.number = io.xpath("orders/order/number").text
    @iorder.status = io.xpath("orders/order/fulfillment-status").text
    @iorder.financial = io.xpath("orders/order/financial-status").text
    @iorder.payment = io.xpath("orders/order/payment-title").text
    @iorder.delivery = io.xpath("orders/order/delivery-title").text 
    @iorder.client = io.xpath("orders/order/client/name").text
    @iorder.phone = io.xpath("orders/order/client/phone").text
    @iorder.email = io.xpath("orders/order/client/email").text
    @iorder.total = io.xpath("orders/order/total-price").text
    #myio = "#{number}, #{status}, #{financial}, #{payment}, #{delivery}, #{client}, #{phone}, #{email}, #{total}" # выводит данные из массива в строку 
    @iorder.save
    #@iorders = Iorder.create
    end  
  end #if myio
  
  
  desc "Destroy all order data"
  task destroy_all_iorders: :environment do
    Iorder.destroy_all
  end
  
#end