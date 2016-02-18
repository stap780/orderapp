# -*- encoding : utf-8 -*-
desc "emagdownload"
task :emagdownload => :environment do
  require 'mechanize'
  
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
	  
	  Emag.create(:sku => sku, :title => title, :quantity => quantity)
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
	  
	  Emag.create(:sku => sku, :title => title, :quantity => quantity)
	end
	
	a.get("http://www.emag.ru/order/index.php")
	a.page.link_with(:text => "Товары").click
	a.page.link_with(:text => "Телефонные гарнитуры").click
	
	plantro = a.page.link_with(:text => "Гарнитуры для компьютера (наушники с микрофоном)").click
	v = plantro.search('#maintext > #example1 > tr') 
	v.each do |b|
	  sku = b.css('td:nth-child(1)').text  
	  title = b.css('td:nth-child(2)').text 
	  quantity = b.css('td:nth-child(3)').text 
	  
	  Emag.create(:sku => sku, :title => title, :quantity => quantity)
	end
	
	a.get("http://www.emag.ru/order/index.php")
	a.page.link_with(:text => "Товары").click
	a.page.link_with(:text => "Телефонные гарнитуры").click
	
	plantro = a.page.link_with(:text => "Аксессуары для гарнитур профессиональной серии").click
	v = plantro.search('#maintext > #example1 > tr') 
	v.each do |b|
	  sku = b.css('td:nth-child(1)').text  
	  title = b.css('td:nth-child(2)').text 
	  quantity = b.css('td:nth-child(3)').text 
	  
	  Emag.create(:sku => sku, :title => title, :quantity => quantity)
	end
	
	a.get("http://www.emag.ru/order/index.php")
	a.page.link_with(:text => "Товары").click
	a.page.link_with(:text => "Телефонные гарнитуры").click
	
	plantro = a.page.link_with(:text => "Беспроводные гарнитуры DECT и Bluetooth").click
	v = plantro.search('#maintext > #example1 > tr') 
	v.each do |b|
	  sku = b.css('td:nth-child(1)').text  
	  title = b.css('td:nth-child(2)').text 
	  quantity = b.css('td:nth-child(3)').text 
	  
	  Emag.create(:sku => sku, :title => title, :quantity => quantity)
	end
	
	a.get("http://www.emag.ru/order/index.php")
	a.page.link_with(:text => "Товары").click
	a.page.link_with(:text => "Телефонные гарнитуры").click
	
	plantro = a.page.link_with(:text => "Адаптеры и шнуры для гарнитур H- и HW- серии").click
	v = plantro.search('#maintext > #example1 > tr') 
	v.each do |b|
	  sku = b.css('td:nth-child(1)').text  
	  title = b.css('td:nth-child(2)').text 
	  quantity = b.css('td:nth-child(3)').text 
	  
	  Emag.create(:sku => sku, :title => title, :quantity => quantity)
	end
	
	a.get("http://www.emag.ru/order/index.php")
	a.page.link_with(:text => "Товары").click
	a.page.link_with(:text => "Телефонные гарнитуры").click
	
	plantro = a.page.link_with(:text => "Аксессуары и запасные части для беспроводных гарнитур Plantronics").click
	v = plantro.search('#maintext > #example1 > tr') 
	v.each do |b|
	  sku = b.css('td:nth-child(1)').text  
	  title = b.css('td:nth-child(2)').text 
	  quantity = b.css('td:nth-child(3)').text 
	  
	  Emag.create(:sku => sku, :title => title, :quantity => quantity)
	end
	
	a.get("http://www.emag.ru/order/index.php")
	a.page.link_with(:text => "Товары").click
	a.page.link_with(:text => "Телефонные гарнитуры").click
	
	plantro = a.page.link_with(:text => "USB телефоны и спикерфоны Plantronics").click
	v = plantro.search('#maintext > #example1 > tr') 
	v.each do |b|
	  sku = b.css('td:nth-child(1)').text  
	  title = b.css('td:nth-child(2)').text 
	  quantity = b.css('td:nth-child(3)').text 
	  
	  Emag.create(:sku => sku, :title => title, :quantity => quantity)
	end
	
	a.get("http://www.emag.ru/order/index.php")
	a.page.link_with(:text => "Товары").click
	a.page.link_with(:text => "Системы поддержки распределенных конференций").click
	
	konftel = a.page.link_with(:text => "Konftel - телефоны для конференц-связи").click
	v = konftel.search('#maintext > #example1 > tr') 
	v.each do |b|
	
	  sku = b.css('td:nth-child(1)').text  
	  title = b.css('td:nth-child(2)').text 
	  quantity = b.css('td:nth-child(3)').text 
	  
	  Emag.create(:sku => sku, :title => title, :quantity => quantity)
	   
	end
	
	a.get("http://www.emag.ru/order/index.php")
	a.page.link_with(:text => "Товары").click
	a.page.link_with(:text => "Системы поддержки распределенных конференций").click
	
	konftel = a.page.link_with(:text => "Комплекты дополнительных микрофонов для конференц-телефонов Konftel").click
	v = konftel.search('#maintext > #example1 > tr') 
	v.each do |b|
	  sku = b.css('td:nth-child(1)').text  
	  title = b.css('td:nth-child(2)').text 
	  quantity = b.css('td:nth-child(3)').text 
	  
	  Emag.create(:sku => sku, :title => title, :quantity => quantity)
	end
	
	a.get("http://www.emag.ru/order/index.php")
	a.page.link_with(:text => "Товары").click
	a.page.link_with(:text => "Вспомогательное оборудование для АТС").click
	
	adapter = a.page.link_with(:text => "Аналоговые VoIP шлюзы FXS / FXO (компактные)").click
	v = adapter.search('#maintext > #example1 > tr') 
	v.each do |b|
	  sku = b.css('td:nth-child(1)').text  
	  title = b.css('td:nth-child(2)').text 
	  quantity = b.css('td:nth-child(3)').text 
	  
	  Emag.create(:sku => sku, :title => title, :quantity => quantity)
	end
	#_______________________________
	
	a.get("http://www.emag.ru/order/index.php")
	a.page.link_with(:text => "Товары").click
	a.page.link_with(:text => "Вспомогательное оборудование для АТС").click
	
	adapter = a.page.link_with(:text => "AddPac AP-GS1001 - VoIP-GSM шлюзы").click
	v = adapter.search('#maintext > #example1 > tr') 
	v.each do |b|
	  sku = b.css('td:nth-child(1)').text  
	  title = b.css('td:nth-child(2)').text 
	  quantity = b.css('td:nth-child(3)').text 
	  
	  Emag.create(:sku => sku, :title => title, :quantity => quantity)
	end
	
	a.get("http://www.emag.ru/order/index.php")
	a.page.link_with(:text => "Товары").click
	a.page.link_with(:text => "Вспомогательное оборудование для АТС").click
	
	adapter = a.page.link_with(:text => "AddPac AP-GS1002 - VoIP-GSM шлюз").click
	v = adapter.search('#maintext > #example1 > tr') 
	v.each do |b|
	  sku = b.css('td:nth-child(1)').text  
	  title = b.css('td:nth-child(2)').text 
	  quantity = b.css('td:nth-child(3)').text 
	  
	  Emag.create(:sku => sku, :title => title, :quantity => quantity)
	end
	
	a.get("http://www.emag.ru/order/index.php")
	a.page.link_with(:text => "Товары").click
	a.page.link_with(:text => "Вспомогательное оборудование для АТС").click
	
	adapter = a.page.link_with(:text => "AddPac AP-GS1004 - VoIP (SIP) - GSM шлюз").click
	v = adapter.search('#maintext > #example1 > tr') 
	v.each do |b|
	  sku = b.css('td:nth-child(1)').text  
	  title = b.css('td:nth-child(2)').text 
	  quantity = b.css('td:nth-child(3)').text 
	  
	  Emag.create(:sku => sku, :title => title, :quantity => quantity)
	end
	
	a.get("http://www.emag.ru/order/index.php")
	a.page.link_with(:text => "Товары").click
	a.page.link_with(:text => "Вспомогательное оборудование для АТС").click
	
	adapter = a.page.link_with(:text => "IP системы оповещения").click
	v = adapter.search('#maintext > #example1 > tr') 
	v.each do |b|
	  sku = b.css('td:nth-child(1)').text  
	  title = b.css('td:nth-child(2)').text 
	  quantity = b.css('td:nth-child(3)').text 
	  
	  Emag.create(:sku => sku, :title => title, :quantity => quantity)
	end
	
	a.get("http://www.emag.ru/order/index.php")
	a.page.link_with(:text => "Товары").click
	a.page.link_with(:text => "Вспомогательное оборудование для АТС").click
	
	adapter = a.page.link_with(:text => "IP системы оповещения с функцией обратной связи").click
	v = adapter.search('#maintext > #example1 > tr') 
	v.each do |b|
	  sku = b.css('td:nth-child(1)').text  
	  title = b.css('td:nth-child(2)').text 
	  quantity = b.css('td:nth-child(3)').text 
	  
	  Emag.create(:sku => sku, :title => title, :quantity => quantity)
	end
	
end