#encoding: utf-8
class Emag < ActiveRecord::Base
has_many :products
validates :sku, uniqueness: true

require 'mechanize'
require 'nokogiri'
require 'open-uri'
require 'rake'
require "logger"


	def self.to_csv(options = {})
    CSV.generate(options) do |csv|
      csv << column_names
      all.each do |emag|
        csv << emag.attributes.values_at(*column_names)
      end
    end
	end

	def self.import(file)
	
	spreadsheet = open_spreadsheet(file) 
		(11..spreadsheet.last_row).each do |i|
		
		sku = spreadsheet.cell(i,'A')
		title = spreadsheet.cell(i,'B')
		quantity = spreadsheet.cell(i,'C').to_i
		price = spreadsheet.cell(i,'D').to_f
		cost_price = spreadsheet.cell(i,'E').to_f
		discount = spreadsheet.cell(i,'F').to_i
		
		@emag = Emag.find_by_sku("#{sku}")
		if @emag.present? 
		@emag.update_attributes( :sku => sku, :title => title, :price => price, :cost_price => cost_price, :quantity => quantity, :discount => discount)
		else
		@emag = Emag.new( :sku => sku, :title => title, :price => price, :cost_price => cost_price, :quantity => quantity, :discount => discount)
 		@emag.save
 		end
		 		
		end
	end
  
   def self.open_spreadsheet(file)
    case File.extname(file.original_filename)
    when ".csv" then Roo::CSV.new(file.path, csv_options: {col_sep: ","})
    when ".xls" then Roo::Excel.new(file.path)
    when ".xlsx" then Roo::Excelx.new(file.path)
    when ".XLS" then Roo::Excel.new(file.path)
    else raise "Unknown file type: #{file.original_filename}"
    end
  end

	def self.updateproduct
    
    a = Mechanize.new
	a.get("http://www.emag.ru/order/index.php")
	form = a.page.forms.last
	form.username = "zakaz@teletri.ru"
	form.password = "ddfd817f"
	form.submit
	a.page.link_with(:text => "Товары").click  
	
	a.page.link_with(:text => "Телефонные гарнитуры").click
	plantro = a.page.link_with(:text => "Профессиональные гарнитуры Plantronics").click
	@emag = plantro.search('#maintext > #example1 > tr') 
	@emag.each do |b|
		@emags = Emag.where("sku = ?",b.css('td:nth-child(1)').text)
	  sku = b.css('td:nth-child(1)').text  
	  title = b.css('td:nth-child(2)').text 
	  quantity = b.css('td:nth-child(3)').text 
	  
	   @emags.each do |b|
        b.update_attributes(:sku => sku, :title => title, :quantity => quantity)
        end
	end
	
	a.get("http://www.emag.ru/order/index.php")
	a.page.link_with(:text => "Товары").click
	a.page.link_with(:text => "Телефонные гарнитуры").click
	
	plantro = a.page.link_with(:text => "Гарнитуры для малого офиса (SOHO)").click
	@emag = plantro.search('#maintext > #example1 > tr') 
	@emag.each do |b|
		@emags = Emag.where("sku = ?", b.css('td:nth-child(1)').text)
	  sku = b.css('td:nth-child(1)').text  
	  title = b.css('td:nth-child(2)').text 
	  quantity = b.css('td:nth-child(3)').text 
	  
	   @emags.each do |b|
        b.update_attributes(:sku => sku, :title => title, :quantity => quantity)
        end
	end
	
	a.get("http://www.emag.ru/order/index.php")
	a.page.link_with(:text => "Товары").click
	a.page.link_with(:text => "Телефонные гарнитуры").click
	
	plantro = a.page.link_with(:text => "Гарнитуры для компьютера (наушники с микрофоном)").click
	@emag = plantro.search('#maintext > #example1 > tr') 
	@emag.each do |b|
		@emags = Emag.where("sku = ?", b.css('td:nth-child(1)').text)
	  sku = b.css('td:nth-child(1)').text  
	  title = b.css('td:nth-child(2)').text 
	  quantity = b.css('td:nth-child(3)').text 
	  
	   @emags.each do |b|
        b.update_attributes(:sku => sku, :title => title, :quantity => quantity)
        end
	end
	
	a.get("http://www.emag.ru/order/index.php")
	a.page.link_with(:text => "Товары").click
	a.page.link_with(:text => "Телефонные гарнитуры").click
	
	plantro = a.page.link_with(:text => "Аксессуары для гарнитур профессиональной серии").click
	@emag = plantro.search('#maintext > #example1 > tr') 
	@emag.each do |b|
		@emags = Emag.where("sku = ?", b.css('td:nth-child(1)').text)
	  sku = b.css('td:nth-child(1)').text  
	  title = b.css('td:nth-child(2)').text 
	  quantity = b.css('td:nth-child(3)').text 
	  
	   @emags.each do |b|
        b.update_attributes(:sku => sku, :title => title, :quantity => quantity)
        end
	end
	
	a.get("http://www.emag.ru/order/index.php")
	a.page.link_with(:text => "Товары").click
	a.page.link_with(:text => "Телефонные гарнитуры").click
	
	plantro = a.page.link_with(:text => "Беспроводные гарнитуры DECT и Bluetooth").click
	@emag = plantro.search('#maintext > #example1 > tr') 
	@emag.each do |b|
		@emags = Emag.where("sku = ?", b.css('td:nth-child(1)').text)
	  sku = b.css('td:nth-child(1)').text  
	  title = b.css('td:nth-child(2)').text 
	  quantity = b.css('td:nth-child(3)').text 
	  
	   @emags.each do |b|
        b.update_attributes(:sku => sku, :title => title, :quantity => quantity)
        end
	end
	
	a.get("http://www.emag.ru/order/index.php")
	a.page.link_with(:text => "Товары").click
	a.page.link_with(:text => "Телефонные гарнитуры").click
	
	plantro = a.page.link_with(:text => "Адаптеры и шнуры для гарнитур H- и HW- серии").click
	@emag = plantro.search('#maintext > #example1 > tr') 
	@emag.each do |b|
		@emags = Emag.where("sku = ?", b.css('td:nth-child(1)').text)
	  sku = b.css('td:nth-child(1)').text  
	  title = b.css('td:nth-child(2)').text 
	  quantity = b.css('td:nth-child(3)').text 
	  
	   @emags.each do |b|
        b.update_attributes(:sku => sku, :title => title, :quantity => quantity)
        end
	end
	
	a.get("http://www.emag.ru/order/index.php")
	a.page.link_with(:text => "Товары").click
	a.page.link_with(:text => "Телефонные гарнитуры").click
	
	plantro = a.page.link_with(:text => "Аксессуары и запасные части для беспроводных гарнитур Plantronics").click
	@emag = plantro.search('#maintext > #example1 > tr') 
	@emag.each do |b|
		@emags = Emag.where("sku = ?", b.css('td:nth-child(1)').text)
	  sku = b.css('td:nth-child(1)').text  
	  title = b.css('td:nth-child(2)').text 
	  quantity = b.css('td:nth-child(3)').text 
	  
	   @emags.each do |b|
        b.update_attributes(:sku => sku, :title => title, :quantity => quantity)
        end
	end
	
	a.get("http://www.emag.ru/order/index.php")
	a.page.link_with(:text => "Товары").click
	a.page.link_with(:text => "Телефонные гарнитуры").click
	
	plantro = a.page.link_with(:text => "USB телефоны и спикерфоны Plantronics").click
	@emag = plantro.search('#maintext > #example1 > tr') 
	@emag.each do |b|
		@emags = Emag.where("sku = ?", b.css('td:nth-child(1)').text)
	  sku = b.css('td:nth-child(1)').text  
	  title = b.css('td:nth-child(2)').text 
	  quantity = b.css('td:nth-child(3)').text 
	  
	   @emags.each do |b|
        b.update_attributes(:sku => sku, :title => title, :quantity => quantity)
        end
	end
	
	a.get("http://www.emag.ru/order/index.php")
	a.page.link_with(:text => "Товары").click
	a.page.link_with(:text => "Системы поддержки распределенных конференций").click
	
	konftel = a.page.link_with(:text => "Konftel - телефоны для конференц-связи").click
	@emag = konftel.search('#maintext > #example1 > tr') 
	@emag.each do |b|
		@emags = Emag.where("sku = ?", b.css('td:nth-child(1)').text)
	  sku = b.css('td:nth-child(1)').text  
	  title = b.css('td:nth-child(2)').text 
	  quantity = b.css('td:nth-child(3)').text 
	  
	   @emags.each do |b|
        b.update_attributes(:sku => sku, :title => title, :quantity => quantity)
        end
	end
	
	a.get("http://www.emag.ru/order/index.php")
	a.page.link_with(:text => "Товары").click
	a.page.link_with(:text => "Системы поддержки распределенных конференций").click
	
	konftel = a.page.link_with(:text => "Комплекты дополнительных микрофонов для конференц-телефонов Konftel").click
	@emag = konftel.search('#maintext > #example1 > tr') 
	@emag.each do |b|
		@emags = Emag.where("sku = ?", b.css('td:nth-child(1)').text)
	  sku = b.css('td:nth-child(1)').text  
	  title = b.css('td:nth-child(2)').text 
	  quantity = b.css('td:nth-child(3)').text 
	  
	   @emags.each do |b|
        b.update_attributes(:sku => sku, :title => title, :quantity => quantity)
        end
	end
	
	a.get("http://www.emag.ru/order/index.php")
	a.page.link_with(:text => "Товары").click
	a.page.link_with(:text => "Вспомогательное оборудование для АТС").click
	
	adapter = a.page.link_with(:text => "Аналоговые VoIP шлюзы FXS / FXO (компактные)").click
	@emag = adapter.search('#maintext > #example1 > tr') 
	@emag.each do |b|
		@emags = Emag.where("sku = ?", b.css('td:nth-child(1)').text)
	  sku = b.css('td:nth-child(1)').text  
	  title = b.css('td:nth-child(2)').text 
	  quantity = b.css('td:nth-child(3)').text 
	  
	   @emags.each do |b|
        b.update_attributes(:sku => sku, :title => title, :quantity => quantity)
        end
	end
	
	#__________________________
	
	a.get("http://www.emag.ru/order/index.php")
	a.page.link_with(:text => "Товары").click
	a.page.link_with(:text => "Вспомогательное оборудование для АТС").click
	
	adapter = a.page.link_with(:text => "AddPac AP-GS1001 - VoIP-GSM шлюзы").click
	@emag = adapter.search('#maintext > #example1 > tr') 
	@emag.each do |b|
		@emags = Emag.where("sku = ?", b.css('td:nth-child(1)').text)
	  sku = b.css('td:nth-child(1)').text  
	  title = b.css('td:nth-child(2)').text 
	  quantity = b.css('td:nth-child(3)').text 
	  
	   @emags.each do |b|
        b.update_attributes(:sku => sku, :title => title, :quantity => quantity)
        end
	end
	
	a.get("http://www.emag.ru/order/index.php")
	a.page.link_with(:text => "Товары").click
	a.page.link_with(:text => "Вспомогательное оборудование для АТС").click
	
	adapter = a.page.link_with(:text => "AddPac AP-GS1002 - VoIP-GSM шлюз").click
	@emag = adapter.search('#maintext > #example1 > tr') 
	@emag.each do |b|
		@emags = Emag.where("sku = ?", b.css('td:nth-child(1)').text)
	  sku = b.css('td:nth-child(1)').text  
	  title = b.css('td:nth-child(2)').text 
	  quantity = b.css('td:nth-child(3)').text 
	  
	   @emags.each do |b|
        b.update_attributes(:sku => sku, :title => title, :quantity => quantity)
        end
	end
	
	a.get("http://www.emag.ru/order/index.php")
	a.page.link_with(:text => "Товары").click
	a.page.link_with(:text => "Вспомогательное оборудование для АТС").click
	
	adapter = a.page.link_with(:text => "AddPac AP-GS1004 - VoIP (SIP) - GSM шлюз").click
	@emag = adapter.search('#maintext > #example1 > tr') 
	@emag.each do |b|
		@emags = Emag.where("sku = ?", b.css('td:nth-child(1)').text)
	  sku = b.css('td:nth-child(1)').text  
	  title = b.css('td:nth-child(2)').text 
	  quantity = b.css('td:nth-child(3)').text 
	  
	   @emags.each do |b|
        b.update_attributes(:sku => sku, :title => title, :quantity => quantity)
        end
	end
	
	a.get("http://www.emag.ru/order/index.php")
	a.page.link_with(:text => "Товары").click
	a.page.link_with(:text => "Вспомогательное оборудование для АТС").click
	
	adapter = a.page.link_with(:text => "IP системы оповещения").click
	@emag = adapter.search('#maintext > #example1 > tr') 
	@emag.each do |b|
		@emags = Emag.where("sku = ?", b.css('td:nth-child(1)').text)
	  sku = b.css('td:nth-child(1)').text  
	  title = b.css('td:nth-child(2)').text 
	  quantity = b.css('td:nth-child(3)').text 
	  
	   @emags.each do |b|
        b.update_attributes(:sku => sku, :title => title, :quantity => quantity)
        end
	end
	
	a.get("http://www.emag.ru/order/index.php")
	a.page.link_with(:text => "Товары").click
	a.page.link_with(:text => "Вспомогательное оборудование для АТС").click
	
	adapter = a.page.link_with(:text => "IP системы оповещения с функцией обратной связи").click
	@emag = adapter.search('#maintext > #example1 > tr') 
	@emag.each do |b|
		@emags = Emag.where("sku = ?", b.css('td:nth-child(1)').text)
	  sku = b.css('td:nth-child(1)').text  
	  title = b.css('td:nth-child(2)').text 
	  quantity = b.css('td:nth-child(3)').text 
	  
	   @emags.each do |b|
        b.update_attributes(:sku => sku, :title => title, :quantity => quantity)
        end
	end
    
   	end
   	
   	
end
