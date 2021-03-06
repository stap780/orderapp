# -*- encoding : utf-8 -*-

require 'rails/all'
require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'json'
require 'mechanize'
#require 'addressable/uri'
require 'savon'


def synchro # cработало но в терминале ? а из файла нет - это позволило прописать id поставщика на основе sku в таблице продукты

  @energies = Energy.order("title")
    @energies.each do |e|
    mysku = e.sku
    myid = e.id
    @products = Product.where("sku = ?", mysku)
  	@products.each do |p|
  	 p.energy_id = myid	
  	 p.save 
  	end
  end
  
  
  @emags = Emag.order("sku")
    @emags.each do |e|
    mysku = e.sku
    myid = e.id
    @products = Product.where("sku = ?", mysku)
  	 @products.each do |p|
  	 p.emag_id = myid	
  	 p.save 
  	 end	
  end
end

# __________________________________________________________________________

# @products = Product.order("sku") # обновление кол-ва в таблице Энерджи на основе таблицы Продукты
# @products.each do |p|
# mysku = p.sku
# myq = p.quantity
# @energies = Energy.where("sku = ?", mysku)
# @energies.each do  |e|
# e.quantity = myq
# e.save
# end
# end


# __________________________________________________________________________

def search
@energy = Energy.where("sku=?","BR-AGCF2W")
@energy.products.each do |e|
   p = e.inid
 
url = URI.encode("http://a2e2ed5ba6560944845dbf38f2223298:0e734e3c93ca9795f87313c83c5ebbcf@worksys.myinsales.ru/admin/products/#{(p)}.xml")  
data = Nokogiri::XML(open(url))
  
puts data
end
end


	def icr
	
	page = open('http://store.et-battery.com/api/stores/1/products', :http_basic_authentication => ['panaet80@mail.ru','49UCR0Fnc4R95Mahz8oz5sAne099V50o'])
	contents = page.read

	data = JSON.parse(contents)
	h = data["products"]
	h.each do |h|
	icr_id = h["product_id"]
	title = h["product"]
	price_usd = h["price"]
	
	url = "http://www.cbr.ru/scripts/XML_daily.asp"
	data = Nokogiri::XML(open(url))
	kurs = data.xpath("ValCurs/Valute[@ID = 'R01235']/Value").text
	a = kurs.gsub(/,/, '.').to_f
	
	puts "#{icr_id} - #{title} - #{price_usd}"
	puts "#{kurs}"
	puts "#{a}"
	end
	end
	
	def iml
	url = "https://api.iml.ru/list/sd                                           "
	data = open(url, :http_basic_authentication => ['03584', 'uK8$o$iC'])
	contents = data.read
	h = JSON.parse(contents)
	h.each do |h|
	code = h["Code"]
	puts "#{code}"
	end
  end
	
	def checkstatus # не работает
	# @iorders = Iorder.where("mycourier_id" => "1")
#     @iorders.each do |io|
#     myimlid = io.iml_id
#     imls = Iml.where("id" => myimlid)
#     puts imls
#     imls.each do |iml|
#         if iml.statusnum = "1"
#         io.status = Status.find_by_number("7")
#         else 
#         if iml.statusnum = "3"
#         io.status = Status.find_by_number("8")
#         end
#         end
#         io.save
#         end
#         
#          uri = "http://a2e2ed5ba6560944845dbf38f2223298:0e734e3c93ca9795f87313c83c5ebbcf@worksys.myinsales.ru/admin/orders/#{(io.inid)}.xml"
#     
#       response = RestClient.put uri, "<order><fulfillment-status>#{(io.status.instatus)}</fulfillment-status></order>", :accept => :xml, :content_type => "application/xml"
#         
#         end
#   

	end
	

	def citilink
	a = Mechanize.new
	mypage = a.get("http://www.citilink.ru/catalog/furniture/phones/phones_ip/?available=1&p=1")
	#mypage = Nokogiri::HTML(open("http://www.citilink.ru/catalog/furniture/phones/phones_ip/?available=1&p=1"))
	
	product = mypage.search('#subcategoryList > div.product_category_list > table > tbody')
	product.each do|pr|
	title = pr.search('tr:nth-child(1) > td.product_name.cms_item_panel > span > a').text
	price = pr.search('tr:nth-child(2) > td.prices_container > div > span.standart > span > ins.num').text
	price1 = pr.search('tr:nth-child(2) > td.prices_container > div > span.special > span  > ins.num').text
	q1 = pr.search('tr:nth-child(1) > td.product_name.cms_item_panel > div.in_stock_horizontal_position > span:nth-child(1) > span').text
	q2 = pr.search('tr:nth-child(1) > td.product_name.cms_item_panel > div.in_stock_horizontal_position > span:nth-child(2) > span').text
	q3 = pr.search('tr:nth-child(1) > td.product_name.cms_item_panel > div.in_stock_horizontal_position > span:nth-child(3) > span').text
	q4 = pr.search('tr:nth-child(1) > td.product_name.cms_item_panel > div.in_stock_horizontal_position > span:nth-child(4) > span').text
	q5 = pr.search('tr:nth-child(1) > td.product_name.cms_item_panel > div.in_stock_horizontal_position > span:nth-child(5) > span').text
	
	puts  "#{title} --- #{price} --- #{price1} --- #{q1} --- #{q2} --- #{q3} --- #{q4} --- #{q5}"
	end
	mypage = a.get("http://www.citilink.ru/catalog/furniture/phones/phones_ip/?available=1&p=2")
	product = mypage.search('#subcategoryList > div.product_category_list > table > tbody')
	product.each do|pr|
	title = pr.search('tr:nth-child(1) > td.product_name.cms_item_panel > span > a').text
	price = pr.search('tr:nth-child(2) > td.prices_container > div > span.standart > span > ins.num').text
	price1 = pr.search('tr:nth-child(2) > td.prices_container > div > span.special > span  > ins.num').text
	q1 = pr.search('tr:nth-child(1) > td.product_name.cms_item_panel > div.in_stock_horizontal_position > span:nth-child(1) > span').text
	q2 = pr.search('tr:nth-child(1) > td.product_name.cms_item_panel > div.in_stock_horizontal_position > span:nth-child(2) > span').text
	q3 = pr.search('tr:nth-child(1) > td.product_name.cms_item_panel > div.in_stock_horizontal_position > span:nth-child(3) > span').text
	q4 = pr.search('tr:nth-child(1) > td.product_name.cms_item_panel > div.in_stock_horizontal_position > span:nth-child(4) > span').text
	q5 = pr.search('tr:nth-child(1) > td.product_name.cms_item_panel > div.in_stock_horizontal_position > span:nth-child(5) > span').text
	
	puts  "#{title} --- #{price} --- #{price1} --- #{q1} --- #{q2} --- #{q3} --- #{q4} --- #{q5}"
	end
	end
	
	def class_api

		page = open('https://teletri.class365.ru/api/rest/repair.json?app_id=467986&app_psw=8bd74ce8aa8fe5226a861e5afab88482')
		contents = page.read
		h = JSON.parse(contents)
		token = h["token"]
		app_psw_j = h["app_psw"]
		
		app_psw = Digest::MD5.hexdigest("#{token}" + "O9CxBF98TjsKziqf73az5MSl8i1RhSyW" + "app_id=467986")
		puts "#{app_psw}"
		# uri = Addressable::URI.parse("https://teletri.class365.ru/api/rest/goods.json?app_id=467986&app_psw=#{app_psw}")
# 		url = uri.normalize
# 		goods = open(url)
# 		gcontents = goods.read
# 		g = JSON.parse(gcontents)
		
		
		# uri = Addressable::URI.parse("https://teletri.class365.ru/api/rest/customerorders.json?app_id=467986&app_psw=#{app_psw}&help=1")
# 		url = uri.normalize
# 		orders = open(url)
# 		ocontents = orders.read
# 		o = JSON.parse(ocontents)["result"][0]
# 		puts "#{o}"
	end

	def dpd
	client = Savon.client(wsdl: "http://ws.dpd.ru:80/services/tracing1-1?wsdl")
	
	response = client.call(:get_states_by_client_order, message: { request: { auth:{clientNumber: "1001031371", clientKey: "DDCEEA16D6A7BBAF6B2C276E4292B53942766CC1"}, clientOrderNr: "7946"}})
	#puts response
	data = response.body
	docid = data[:get_states_by_client_order_response][ :return][:doc_id]
	states = data[:get_states_by_client_order_response][ :return][:states].to_a
	dpdnumber = states[0][:dpd_order_nr]
	pickupdate = states[0][:pickup_date]
	plandeliverytime = states[0][:plan_delivery_date]
	state = states.last[:new_state]
	
	puts "#{dpdnumber} --- #{pickupdate} --- #{plandeliverytime} --- #{state}"
	
	
	end
	
	def order
	
	# url = "http://worksys.myinsales.ru/admin/orders.xml"
#      data = Nokogiri::XML(open(url, :http_basic_authentication => ['a2e2ed5ba6560944845dbf38f2223298' ,'0e734e3c93ca9795f87313c83c5ebbcf']))
#      
#      order = "orders/order" #определение категории в файле в переменную
#      
#      myio = data.xpath(order).first
    
    url = "http://worksys.myinsales.ru/admin/orders/6161602.xml"
    data = Nokogiri::XML(open(url, :http_basic_authentication => ['a2e2ed5ba6560944845dbf38f2223298' ,'0e734e3c93ca9795f87313c83c5ebbcf']))
     myio = data.xpath("order/order-lines/order-line")
     myio.each do |myio|
     variantid = myio.xpath("variant-id").text
     quantity = myio.xpath("quantity").text
     price = myio.xpath("full-sale-price").text 
     
     #puts myio
     puts "#{variantid} --- #{quantity} --- #{price}"
	end
	deliveryprice = myio.xpath("//full-delivery-price").text
	puts "#{deliveryprice}"
	end
	
	def myimage
	
	energy = Energy.order("id")
	agent = Mechanize.new
	agent.robots = false
	agent.user_agent_alias = 'Mac Safari'
	energy.each do |en|
	link = en.image_url
	b = en.sku.gsub(/\W/,'-')
	agent.get(link).save "app/assets/images/et_img/#{b}.jpg"
	end
	end





#myimage
#order
#dpd
#class_api	
#citilink	
#checkstatus
#icr
#search
#synchro