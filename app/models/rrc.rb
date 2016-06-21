#encoding: utf-8
class Rrc < ActiveRecord::Base
	
	has_many :products
	validates :sku, uniqueness: true
	require 'roo'
	require 'roo-xls'

	def self.to_csv(options = {})
    CSV.generate(options) do |csv|
      csv << column_names
      all.each do |rrc|
        csv << rrc.attributes.values_at(*column_names)
      end
    end
  end

def self.import(file)
    
    spreadsheet = open_spreadsheet(file) 
     (7..spreadsheet.last_row).each do |i|  
       sku = spreadsheet.cell(i,'A').to_s
       title = spreadsheet.cell(i,'B')
       a = spreadsheet.cell(i,'E').to_s
       if a == '+ + +'
       quantity = a.gsub('+ + +', '100').to_i
       else
       if a == '+++'
       quantity = a.gsub('+++', '100').to_i
       else
       if a == '+ +'
       quantity = a.gsub('+ +', '30').to_i
       else
       if a == '++'
       quantity = a.gsub('++', '30').to_i
       else
       if a == '+'
       quantity = a.gsub('+', '10').to_i
       else
       quantity = a.to_i 
       end
       end
       end
       end
       end
       
       cost_price = spreadsheet.cell(i,'H').to_f
       if cost_price > 500
       price = cost_price*1.11
       else
       price = cost_price*1.15
       end
       @rrc = Rrc.find_by_sku("#{sku}")
		if @rrc.present? 
		@rrc.update_attributes( :title => title, :quantity => quantity, :cost_price => cost_price, :price => price)
		# else
# 		@rrc = rrc.new(:sku => sku, :title => title, :quantity => quantity, :cost_price => cost_price)
#  		@rrc.save
 		end
       
    end
  end
  
   def self.open_spreadsheet(file)
    case File.extname(file.original_filename)
    when ".csv" then Roo::Csv.new(file.path, csv_options: {col_sep: ";"})
    when ".xls" then Roo::Excel.new(file.path)
    when ".xlsx" then Roo::Excelx.new(file.path)
    when ".XLS" then Roo::Excel.new(file.path)
    else raise "Unknown file type: #{file.original_filename}"
    end
  end

  
 #  def self.updateproduct
# 
# 	  a = Mechanize.new { |agent| agent.user_agent_alias = "Windows IE 7" }
#       a.cookie_jar.clear!  
#     a.get("http://www.rrc.ru/catalog/")
#     form = a.page.forms.last
#     form.USER_LOGIN = "Панает.Эмексизов"
#     form.USER_PASSWORD = "z9j08F6"
#     form.submit
#     
#     cisco = a.page.link_with(:text => "VoIP").click
#     @rrc = cisco.search("#x-product-items > table > tbody")   
#     @rrc.each do |b|
#       @rrcs = Rrc.where("sku = ?", b.css('tr:nth-child(1) > td:nth-child(1)').text.gsub(/[ \t\r\n\f ]/,'').gsub("Аналоги",''))
#       
#       sku = b.css('tr:nth-child(1) > td:nth-child(1)').text.gsub(/[ \t\r\n\f ]/,'').gsub("Аналоги",'')
#       title = b.css('tr:nth-child(1) > td.b-catalog-productName > a').text        
#       quantity = b.css('tr:nth-child(1) > td:nth-child(4)').text.gsub(/[ \t\r\n\f]/,'')
#         
#         @rrcs.each do |b|
#         b.update_attributes(:sku => sku, :title => title, :quantity => quantity)
#         end
#         
#     end
#     
#     a.get("http://www.rrc.ru/catalog/")
#    
#    cisco = a.page.link_with(:text => "Коммутаторы").click
#     
#     @rrc = cisco.search("#x-product-items > table > tbody")   
#     @rrc.each do |b|
#       @rrcs = Rrc.where("sku = ?", b.css('tr:nth-child(1) > td:nth-child(1)').text.gsub(/[ \t\r\n\f ]/,'').gsub("Аналоги",''))
#       
#       sku = b.css('tr:nth-child(1) > td:nth-child(1)').text.gsub(/[ \t\r\n\f ]/,'').gsub("Аналоги",'')
#       title = b.css('tr:nth-child(1) > td.b-catalog-productName > a').text        
#       quantity = b.css('tr:nth-child(1) > td:nth-child(4)').text.gsub(/[ \t\r\n\f]/,'')
#         
#         @rrcs.each do |b|
#         b.update_attributes(:sku => sku, :title => title, :quantity => quantity)
#         end
#         
#     end
#     
#     a.get("http://www.rrc.ru/catalog/")
#   
#     yealink = a.page.link_with(:text => "IP-телефоны").click
#     @rrc = yealink.search("#x-product-items > table > tbody")   
#     @rrc.each do |b|
#       @rrcs = Rrc.where("sku = ?", b.css('tr:nth-child(1) > td:nth-child(1)').text.gsub(/[ \t\r\n\f ]/,'').gsub("Аналоги",''))
#       
#       sku = b.css('tr:nth-child(1) > td:nth-child(1)').text.gsub(/[ \t\r\n\f ]/,'').gsub("Аналоги",'')
#       title = b.css('tr:nth-child(1) > td.b-catalog-productName > a').text        
#       quantity = b.css('tr:nth-child(1) > td:nth-child(4)').text.gsub(/[ \t\r\n\f]/,'')
#         
#         @rrcs.each do |b|
#         b.update_attributes(:sku => sku, :title => title, :quantity => quantity)
#         end
#         
#     end
#     
#     a.get("http://www.rrc.ru/catalog/")
#   
#     yealink = a.page.link_with(:text => "IP DECT-телефоны").click
#     @rrc = yealink.search("#x-product-items > table > tbody")   
#     @rrc.each do |b|
#       @rrcs = Rrc.where("sku = ?", b.css('tr:nth-child(1) > td:nth-child(1)').text.gsub(/[ \t\r\n\f ]/,'').gsub("Аналоги",''))
#       
#       sku = b.css('tr:nth-child(1) > td:nth-child(1)').text.gsub(/[ \t\r\n\f ]/,'').gsub("Аналоги",'')
#       title = b.css('tr:nth-child(1) > td.b-catalog-productName > a').text        
#       quantity = b.css('tr:nth-child(1) > td:nth-child(4)').text.gsub(/[ \t\r\n\f]/,'')
#         
#         @rrcs.each do |b|
#         b.update_attributes(:sku => sku, :title => title, :quantity => quantity)
#         end
#         
#     end
#     
#     
#     a.get("http://www.rrc.ru/catalog/")
#   
#     yealink = a.page.link_with(:text => "Аксессуары для IP DECT-телефонов").click
#     @rrc = yealink.search("#x-product-items > table > tbody")   
#     @rrc.each do |b|
#       @rrcs = Rrc.where("sku = ?", b.css('tr:nth-child(1) > td:nth-child(1)').text.gsub(/[ \t\r\n\f ]/,'').gsub("Аналоги",''))
#       
#       sku = b.css('tr:nth-child(1) > td:nth-child(1)').text.gsub(/[ \t\r\n\f ]/,'').gsub("Аналоги",'')
#       title = b.css('tr:nth-child(1) > td.b-catalog-productName > a').text        
#       quantity = b.css('tr:nth-child(1) > td:nth-child(4)').text.gsub(/[ \t\r\n\f]/,'')
#         
#         @rrcs.each do |b|
#         b.update_attributes(:sku => sku, :title => title, :quantity => quantity)
#         end
#         
#     end
#     
#     a.get("http://www.rrc.ru/catalog/")
#   
#     yealink = a.page.link_with(:text => "Аксессуары для IP-телефонов").click
#     @rrc = yealink.search("#x-product-items > table > tbody")   
#     @rrc.each do |b|
#       @rrcs = Rrc.where("sku = ?", b.css('tr:nth-child(1) > td:nth-child(1)').text.gsub(/[ \t\r\n\f ]/,'').gsub("Аналоги",''))
#       
#       sku = b.css('tr:nth-child(1) > td:nth-child(1)').text.gsub(/[ \t\r\n\f ]/,'').gsub("Аналоги",'')
#       title = b.css('tr:nth-child(1) > td.b-catalog-productName > a').text        
#       quantity = b.css('tr:nth-child(1) > td:nth-child(4)').text.gsub(/[ \t\r\n\f]/,'')
#         
#         @rrcs.each do |b|
#         b.update_attributes(:sku => sku, :title => title, :quantity => quantity)
#         end
#         
#     end  
#     
#     a.get("http://www.rrc.ru/catalog/")
#   
#     yealink = a.page.link_with(:text => "Видеоконференцсвязь (ВКС)").click
#     @rrc = yealink.search("#x-product-items > table > tbody")   
#     @rrc.each do |b|
#       @rrcs = Rrc.where("sku = ?", b.css('tr:nth-child(1) > td:nth-child(1)').text.gsub(/[ \t\r\n\f ]/,'').gsub("Аналоги",''))
#       
#       sku = b.css('tr:nth-child(1) > td:nth-child(1)').text.gsub(/[ \t\r\n\f ]/,'').gsub("Аналоги",'')
#       title = b.css('tr:nth-child(1) > td.b-catalog-productName > a').text        
#       quantity = b.css('tr:nth-child(1) > td:nth-child(4)').text.gsub(/[ \t\r\n\f]/,'')
#         
#         @rrcs.each do |b|
#         b.update_attributes(:sku => sku, :title => title, :quantity => quantity)
#         end
#         
#     end
#     
#     a.get("http://www.rrc.ru/catalog/")
#   
#     yealink = a.page.link_with(:text => "IP-видеотелефоны").click
#     @rrc = yealink.search("#x-product-items > table > tbody")   
#     @rrc.each do |b|
#       @rrcs = Rrc.where("sku = ?", b.css('tr:nth-child(1) > td:nth-child(1)').text.gsub(/[ \t\r\n\f ]/,'').gsub("Аналоги",''))
#       
#       sku = b.css('tr:nth-child(1) > td:nth-child(1)').text.gsub(/[ \t\r\n\f ]/,'').gsub("Аналоги",'')
#       title = b.css('tr:nth-child(1) > td.b-catalog-productName > a').text        
#       quantity = b.css('tr:nth-child(1) > td:nth-child(4)').text.gsub(/[ \t\r\n\f]/,'')
#         
#         @rrcs.each do |b|
#         b.update_attributes(:sku => sku, :title => title, :quantity => quantity)
#         end
#         
#     end
#     
#     a.get("http://www.rrc.ru/catalog/")
#   
#     zyxel = a.page.link_with(:text => "Сетевое оборудование").click
#     @rrc = zyxel.search("#x-product-items > table > tbody")   
#     @rrc.each do |b|
#       @rrcs = Rrc.where("sku = ?", b.css('tr:nth-child(1) > td:nth-child(1)').text.gsub(/[ \t\r\n\f ]/,'').gsub("Аналоги",''))
#       
#       sku = b.css('tr:nth-child(1) > td:nth-child(1)').text.gsub(/[ \t\r\n\f ]/,'').gsub("Аналоги",'')
#       title = b.css('tr:nth-child(1) > td.b-catalog-productName > a').text        
#       quantity = b.css('tr:nth-child(1) > td:nth-child(4)').text.gsub(/[ \t\r\n\f]/,'')
#         
#         @rrcs.each do |b|
#         b.update_attributes(:sku => sku, :title => title, :quantity => quantity)
#         end
#         
#     end
# 
#   end



end
