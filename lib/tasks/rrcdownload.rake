# -*- encoding : utf-8 -*-
desc "rrcdownload"
task :rrcdownload => :environment do
  require 'mechanize'
  
  a = Mechanize.new { |agent| agent.user_agent_alias = "Windows IE 7" }
      a.cookie_jar.clear!  
	  a.get("http://www.rrc.ru/catalog/")
 	  form = a.page.forms.last
 	  form.USER_LOGIN = "Панает.Эмексизов"
 	  form.USER_PASSWORD = "z9j08F6"
 	  form.submit
 	  
 	  cisco = a.page.link_with(:text => "VoIP").click
 	  v = cisco.search("#x-product-items > table > tbody") 	 
 		 v.each do |b|
 		 
 		  sku = b.css('tr:nth-child(1) > td:nth-child(1)').text.gsub(/[ \t\r\n\f ]/,'').gsub("Аналоги",'')
 	    title = b.css('tr:nth-child(1) > td.b-catalog-productName > a').text        
 	 	  quantity = b.css('tr:nth-child(1) > td:nth-child(4)').text.gsub(/[ \t\r\n\f]/,'')
 	 	
 	 	Rrc.create(:sku => sku, :title => title, :quantity => quantity)
 	 	  
 		end
 		
 	a.get("http://www.rrc.ru/catalog/")
 	 
	 cisco = a.page.link_with(:text => "Коммутаторы").click
	 v = cisco.search("#x-product-items > table > tbody") 	 
 		 v.each do |b|
 		 
 		 sku = b.css('tr:nth-child(1) > td:nth-child(1)').text.gsub(/[ \t\r\n\f ]/,'').gsub("Аналоги",'')
 	  	 title = b.css('tr:nth-child(1) > td.b-catalog-productName > a').text        
 	 	quantity = b.css('tr:nth-child(1) > td:nth-child(4)').text.gsub(/[ \t\r\n\f]/,'')
 	 	
 	 	Rrc.create(:sku => sku, :title => title, :quantity => quantity)
 	 	     
 		end
 		
 	a.get("http://www.rrc.ru/catalog/")
 	
 	yealink = a.page.link_with(:text => "IP-телефоны").click
 	v = yealink.search("#x-product-items > table > tbody")
 	v.each do |b|
 		 
 		 sku = b.css('tr:nth-child(1) > td:nth-child(1)').text.gsub(/[ \t\r\n\f ]/,'').gsub("Аналоги",'')
 	  	 title = b.css('tr:nth-child(1) > td.b-catalog-productName > a').text        
 	 	quantity = b.css('tr:nth-child(1) > td:nth-child(4)').text.gsub(/[ \t\r\n\f]/,'')
 	 	
 	 	Rrc.create(:sku => sku, :title => title, :quantity => quantity)
 	 	     
 		end
 		
 	a.get("http://www.rrc.ru/catalog/")
 	
 	yealink = a.page.link_with(:text => "IP DECT-телефоны").click
 	v = yealink.search("#x-product-items > table > tbody")
 	v.each do |b|
 		 
 		 sku = b.css('tr:nth-child(1) > td:nth-child(1)').text.gsub(/[ \t\r\n\f ]/,'').gsub("Аналоги",'')
 	  	 title = b.css('tr:nth-child(1) > td.b-catalog-productName > a').text        
 	 	quantity = b.css('tr:nth-child(1) > td:nth-child(4)').text.gsub(/[ \t\r\n\f]/,'')
 	 	
 	 	Rrc.create(:sku => sku, :title => title, :quantity => quantity)
 	 	     
 		end
 		
 	a.get("http://www.rrc.ru/catalog/")
 	
 	yealink = a.page.link_with(:text => "Аксессуары для IP DECT-телефонов").click
 	v = yealink.search("#x-product-items > table > tbody")
 	v.each do |b|
 		 
 		 sku = b.css('tr:nth-child(1) > td:nth-child(1)').text.gsub(/[ \t\r\n\f ]/,'').gsub("Аналоги",'')
 	  	 title = b.css('tr:nth-child(1) > td.b-catalog-productName > a').text        
 	 	quantity = b.css('tr:nth-child(1) > td:nth-child(4)').text.gsub(/[ \t\r\n\f]/,'')
 	 	
 	 	Rrc.create(:sku => sku, :title => title, :quantity => quantity)
 	 	     
 		end

 	a.get("http://www.rrc.ru/catalog/")
 	
 	yealink = a.page.link_with(:text => "Аксессуары для IP-телефонов").click
 	v = yealink.search("#x-product-items > table > tbody")
 	v.each do |b|
 		 
 		 sku = b.css('tr:nth-child(1) > td:nth-child(1)').text.gsub(/[ \t\r\n\f ]/,'').gsub("Аналоги",'')
 	  	 title = b.css('tr:nth-child(1) > td.b-catalog-productName > a').text        
 	 	quantity = b.css('tr:nth-child(1) > td:nth-child(4)').text.gsub(/[ \t\r\n\f]/,'')
 	 	
 	 	Rrc.create(:sku => sku, :title => title, :quantity => quantity)
 	 	     
 		end

 	a.get("http://www.rrc.ru/catalog/")
 	
 	yealink = a.page.link_with(:text => "Видеоконференцсвязь (ВКС)").click
 	v = yealink.search("#x-product-items > table > tbody")
 	v.each do |b|
 		 
 		 sku = b.css('tr:nth-child(1) > td:nth-child(1)').text.gsub(/[ \t\r\n\f ]/,'').gsub("Аналоги",'')
 	  	 title = b.css('tr:nth-child(1) > td.b-catalog-productName > a').text        
 	 	quantity = b.css('tr:nth-child(1) > td:nth-child(4)').text.gsub(/[ \t\r\n\f]/,'')
 	 	
 	 	Rrc.create(:sku => sku, :title => title, :quantity => quantity)
 	 	     
 		end

 	a.get("http://www.rrc.ru/catalog/")
 	
 	yealink = a.page.link_with(:text => "IP-видеотелефоны").click
 	v = yealink.search("#x-product-items > table > tbody")
 	v.each do |b|
 		 
 		 sku = b.css('tr:nth-child(1) > td:nth-child(1)').text.gsub(/[ \t\r\n\f ]/,'').gsub("Аналоги",'')
 	  	 title = b.css('tr:nth-child(1) > td.b-catalog-productName > a').text        
 	 	quantity = b.css('tr:nth-child(1) > td:nth-child(4)').text.gsub(/[ \t\r\n\f]/,'')
 	 	
 	 	Rrc.create(:sku => sku, :title => title, :quantity => quantity)
 	 	     
 		end
 		
 	a.get("http://www.rrc.ru/catalog/")
 	
 	zyxel = a.page.link_with(:text => "Сетевое оборудование").click
 	v = zyxel.search("#x-product-items > table > tbody")
 	v.each do |b|
 		 
 		 sku = b.css('tr:nth-child(1) > td:nth-child(1)').text.gsub(/[ \t\r\n\f ]/,'').gsub("Аналоги",'')
 	  	 title = b.css('tr:nth-child(1) > td.b-catalog-productName > a').text        
 	 	quantity = b.css('tr:nth-child(1) > td:nth-child(4)').text.gsub(/[ \t\r\n\f]/,'')
 	 	
 	 	Rrc.create(:sku => sku, :title => title, :quantity => quantity)
 	 	     
 		end
 	
 	
 end