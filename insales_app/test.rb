# -*- encoding : utf-8 -*-
require 'rails/all'
require 'open-uri'
require 'nokogiri'
require 'rest-client'
require 'insales_api'
require 'roo'
require 'rubygems'
require 'roo-xls'
require 'mechanize'
require 'json'

  def hello
    puts "hello"
  end
  
	def time
	  mytime = Time.now-1.hour
	  puts "#{(mytime)}"
	end
	def emag
	a = Mechanize.new
	a.get("http://www.emag.ru/order/index.php")
	form = a.page.forms.last
	form.username = "zakaz@teletri.ru"
	form.password = "ddfd817f"
	form.submit
	a.page.link_with(:text => "Товары").click  
	
	a.page.link_with(:text => "Телефонные гарнитуры").click
	plantro = a.page.link_with(:text => "Профессиональные гарнитуры Plantronics").click
	v = plantro.search('#maintext > #example1 > tr') 
	v.each do |b|
	  sku = b.css('td:nth-child(1)').text  
	  title = b.css('td:nth-child(2)').text 
	  quantity = b.css('td:nth-child(3)').text 
	  
	  puts "#{sku}  #{title}  #{quantity}"
	end
	
	a.get("http://www.emag.ru/order/index.php")
	a.page.link_with(:text => "Товары").click
	a.page.link_with(:text => "Телефонные гарнитуры").click
	
	plantro = a.page.link_with(:text => "Гарнитуры для малого офиса (SOHO)").click
	v = plantro.search('#maintext > #example1 > tr') 
	v.each do |b|
	  sku = b.css('td:nth-child(1)').text  
	  title = b.css('td:nth-child(2)').text 
	  quantity = b.css('td:nth-child(3)').text 
	  
	  puts "#{sku}  #{title}  #{quantity}"
	end
	
	end
	
	
	def rrc
	  a = Mechanize.new
	  a.get("http://www.rrc.ru/catalog/")
	  form = a.page.forms.last
	  form.USER_LOGIN = "Панает.Эмексизов"
	  form.USER_PASSWORD = "z9j08F6"
	  form.submit
	  
	  cisco = a.page.link_with(:text => "VoIP").click
	  v = cisco.search("#x-product-items > table > tbody") #x-product-items > table > tbody:nth-child(8) > tr:nth-child(1)  	 
		 v.each do |b|
		 sku = b.css('tr:nth-child(1) > td:nth-child(1)').text.gsub(/[ \t\r\n\f ]/,'').gsub("Аналоги",'')
	  	 title = b.css('tr:nth-child(1) > td.b-catalog-productName > a').text #.map(&:text).map(&:strip)        
	 	 quantity = b.css('tr:nth-child(1) > td:nth-child(4)').text.gsub(/[ \t\r\n\f]/,'')     
		 
		 puts "#{sku}  #{title}  #{quantity}"
		 end
		 
	 # a.get("http://www.rrc.ru/catalog/")
# 	 
	 # cisco = a.page.link_with(:text => "Коммутаторы").click
	  # v = cisco.search("#x-product-items > table > tbody") #x-product-items > table > tbody:nth-child(8) > tr:nth-child(1)  	 
		 # v.each do |b|
		 # sku = b.css('tr:nth-child(1) > td:nth-child(1)').text.gsub(/[ \t\r\n\f ]/,'').gsub("Аналоги",'')
	  	 # title = b.css('tr:nth-child(1) > td.b-catalog-productName > a').text #.map(&:text).map(&:strip)        
	 	 # quantity = b.css('tr:nth-child(1) > td:nth-child(4)').text.gsub(/[ \t\r\n\f]/,'')     
# 		 
		 # puts "#{sku}  #{title}  #{quantity}"
		 # end    
# 	
	 # a.get("http://www.rrc.ru/catalog/")
# 		   
	 # yealink = a.page.link_with(:text => "IP-телефоны").click
	 # v = yealink.search("#x-product-items > table > tbody")
		 # v.each do |b|
		 # sku = b.css('tr:nth-child(1) > td:nth-child(1)').text.gsub(/[ \t\r\n\f ]/,'').gsub("Аналоги",'')
		 # title = b.css('tr:nth-child(1) > td.b-catalog-productName > a').text #.map(&:text).map(&:strip)        
		 # quantity = b.css('tr:nth-child(1) > td:nth-child(4)').text.gsub(/[ \t\r\n\f]/,'')
# 		 
		 # puts "#{sku}  #{title}  #{quantity}"
		 # end
# 	 
	 # a.get("http://www.rrc.ru/catalog/")
# 	 
	 # yealink = a.page.link_with(:text => "IP DECT-телефоны").click
	 # v = yealink.search("#x-product-items > table > tbody")
		 # v.each do |b|
		 # sku = b.css('tr:nth-child(1) > td:nth-child(1)').text.gsub(/[ \t\r\n\f ]/,'').gsub("Аналоги",'')
		 # title = b.css('tr:nth-child(1) > td.b-catalog-productName > a').text #.map(&:text).map(&:strip)        
		 # quantity = b.css('tr:nth-child(1) > td:nth-child(4)').text.gsub(/[ \t\r\n\f]/,'')
# 	     
	     # puts "#{sku}  #{title}  #{quantity}"
	     # end
# 	 
	 # a.get("http://www.rrc.ru/catalog/")
# 	 
	 # yealink = a.page.link_with(:text => "Аксессуары для IP DECT-телефонов").click
	 # v = yealink.search("#x-product-items > table > tbody")
		 # v.each do |b|
		 # sku = b.css('tr:nth-child(1) > td:nth-child(1)').text.gsub(/[ \t\r\n\f ]/,'').gsub("Аналоги",'')
		 # title = b.css('tr:nth-child(1) > td.b-catalog-productName > a').text #.map(&:text).map(&:strip)        
		 # quantity = b.css('tr:nth-child(1) > td:nth-child(4)').text.gsub(/[ \t\r\n\f]/,'')
# 	     
	     # puts "#{sku}  #{title}  #{quantity}"
	     # end
# 	 
	 # a.get("http://www.rrc.ru/catalog/")
# 	 
	 # yealink = a.page.link_with(:text => "Аксессуары для IP-телефонов").click
	 # v = yealink.search("#x-product-items > table > tbody")
		 # v.each do |b|
		 # sku = b.css('tr:nth-child(1) > td:nth-child(1)').text.gsub(/[ \t\r\n\f ]/,'').gsub("Аналоги",'')
		 # title = b.css('tr:nth-child(1) > td.b-catalog-productName > a').text #.map(&:text).map(&:strip)        
		 # quantity = b.css('tr:nth-child(1) > td:nth-child(4)').text.gsub(/[ \t\r\n\f]/,'')
# 	     
	     # puts "#{sku}  #{title}  #{quantity}"
	     # end
# 	 
	 # a.get("http://www.rrc.ru/catalog/")
# 	 
	 # yealink = a.page.link_with(:text => "Видеоконференцсвязь (ВКС)").click
	 # v = yealink.search("#x-product-items > table > tbody")
		 # v.each do |b|
		 # sku = b.css('tr:nth-child(1) > td:nth-child(1)').text.gsub(/[ \t\r\n\f ]/,'').gsub("Аналоги",'')
		 # title = b.css('tr:nth-child(1) > td.b-catalog-productName > a').text #.map(&:text).map(&:strip)        
		 # quantity = b.css('tr:nth-child(1) > td:nth-child(4)').text.gsub(/[ \t\r\n\f]/,'')
# 	     
	     # puts "#{sku}  #{title}  #{quantity}"
	     # end
# 	 
	 # a.get("http://www.rrc.ru/catalog/")
# 	 
	 # yealink = a.page.link_with(:text => "IP-видеотелефоны").click
	 # v = yealink.search("#x-product-items > table > tbody")
		 # v.each do |b|
		 # sku = b.css('tr:nth-child(1) > td:nth-child(1)').text.gsub(/[ \t\r\n\f ]/,'').gsub("Аналоги",'')
		 # title = b.css('tr:nth-child(1) > td.b-catalog-productName > a').text #.map(&:text).map(&:strip)        
		 # quantity = b.css('tr:nth-child(1) > td:nth-child(4)').text.gsub(/[ \t\r\n\f]/,'')
# 	     
	     # puts "#{sku}  #{title}  #{quantity}"
	     # end
# 	     
	 # a.get("http://www.rrc.ru/catalog/")
# 	 
	 # zyxel = a.page.link_with(:text => "Сетевое оборудование").click
	 # v = zyxel.search("#x-product-items > table > tbody")
		 # v.each do |b|
		 # sku = b.css('tr:nth-child(1) > td:nth-child(1)').text.gsub(/[ \t\r\n\f ]/,'').gsub("Аналоги",'')
		 # title = b.css('tr:nth-child(1) > td.b-catalog-productName > a').text #.map(&:text).map(&:strip)        
		 # quantity = b.css('tr:nth-child(1) > td:nth-child(4)').text.gsub(/[ \t\r\n\f]/,'')
# 	     
	     # puts "#{sku}  #{title}  #{quantity}"
	     # end
	     
  end
	
	def productupdate
	  mytime = Time.now - 7.hour
    url = URI.encode("http://worksys.myinsales.ru/admin/products.xml?updated_since=#{(mytime)}")
    data = Nokogiri::XML(open(url, :http_basic_authentication => ['a2e2ed5ba6560944845dbf38f2223298' ,'0e734e3c93ca9795f87313c83c5ebbcf']))
    product = "products/product"
    @products = data.xpath(product)
    @products.each do |pr| 
      
    @products = Product.where("inid = ?", pr.xpath("id").text) 
    
    category_id = pr.xpath("category-id").text
    inid = pr.xpath("id").text
    sku = pr.xpath("variants/variant/sku").text
    title = pr.xpath("title").text
    short_description = pr.xpath("short-description").text
    quantity = pr.xpath("variants/variant/quantity").text
    cost_price = pr.xpath("variants/variant/cost-price").text
    price = pr.xpath("variants/variant/price").text
    
    
    @products.update_attributes(:category_id => category_id, :inid => inid, :sku => sku, :title => title, :short_description => short_description, :quantity => quantity, :cost_price => cost_price, :price => price )
    end
	end
	
	 
	def download
	 	url = "http://worksys.myinsales.ru/admin/orders/5152855.xml"
	 	data = Nokogiri::XML(open(url, :http_basic_authentication => ['a2e2ed5ba6560944845dbf38f2223298' ,'0e734e3c93ca9795f87313c83c5ebbcf']))
	 	order = "order" #определение категории в файле в переменную
	 	
	 	myio = data.xpath(order) # определение пути в переменную
	 	
	 	myio.map do |io| # создание хэша из данных заказа и запись их в переменные по каждому заказу
	 	number = io.xpath("number").text
	 	status = io.xpath("fulfillment-status").text
	 	puts "#{number} #{status}"	 	 
	 	end 	
	 end
	   
  
   def product
     url = "http://worksys.myinsales.ru/admin/products.xml"
     #url = "http://worksys.myinsales.ru/admin/products.xml?&limit=20=&page=2"
     data = Nokogiri::XML(open(url, :http_basic_authentication => ['a2e2ed5ba6560944845dbf38f2223298' ,'0e734e3c93ca9795f87313c83c5ebbcf']))
     product = "products/product"
     mypr = data.xpath(product)
     mypr.each do |pr|
      inid = pr.xpath("id").text
      sku = pr.xpath("variants/variant/sku").text
      title = pr.xpath("title").text
      short_description = pr.xpath("short-description").text
      quantity = pr.xpath("variants/variant/quantity").text
      cost_price = pr.xpath("variants/variant/cost-price").text
      price = pr.xpath("variants/variant/price").text
      
     #puts "#{inid} #{sku} #{title} #{short_description} #{quantity} #{cost_price} #{price}"
     puts mypr.count
    end
   end
   #____________________________________
     #data.xpath("//sku").each do |sku|
    #  puts sku.text
    #end
    #___________________________________
    
    def excel
    spreadsheet = Roo::Excel.new('ost.XLS') 
    5.upto(45).each do |i|
    
    artikul = spreadsheet.cell(i,'A').to_i 
    title = spreadsheet.cell(i,'B')
    price = spreadsheet.cell(i,'C')
    valuta = spreadsheet.cell(i,'D') 
    quantity_all_res = spreadsheet.cell(i,'E').to_i 
    quantity_all_free = spreadsheet.cell(i,'F').to_i 
    quantity_main_res = spreadsheet.cell(i,'G').to_i 
    quantity_main_free = spreadsheet.cell(i,'H').to_i 
    quantity_tul_res = spreadsheet.cell(i,'I').to_i 
    quantity_tul_free = spreadsheet.cell(i,'J').to_i
    quantity_transit_all = spreadsheet.cell(i,'K').to_i
    quantity_transit_free = spreadsheet.cell(i,'L').to_i
    
    puts "#{artikul} #{title} #{price} #{valuta} #{quantity_all_res} #{quantity_all_free} #{quantity_main_res} #{quantity_main_free} #{quantity_tul_res} #{quantity_tul_free} #{quantity_transit_all} #{quantity_transit_free}"
     
    #@homyproduct = Homyproduct.create(:artikul => artikul, :title => title, :price => price, :valuta => valuta, :quantity_all_res => quantity_all_res,
    #:quantity_main_res => quantity_main_res, :quantity_tul_res => quantity_tul_res, :quantity_tul_free => quantity_tul_free, :quantity_transit_all => quantity_transit_all,
    # :quantity_transit_free => quantity_transit_free)
    
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
  
 end    

#download   # запуск метода для вывода puts в терминал

hello
#time
#download
#quan
#rrc
#emag
#product
#excel
#productupdate
iml
