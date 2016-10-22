class Homyproduct < ActiveRecord::Base

has_many :products

require 'roo'
require 'roo-xls'
require 'open-uri'

validates :artikul, uniqueness: true

  def self.to_csv(options = {})
    CSV.generate(options) do |csv|
      csv << column_names
      all.each do |homyproduct|
        csv << homyproduct.attributes.values_at(*column_names)
      end
    end
  end
  
  def self.import(file)
    #Homyproduct.destroy_all #- удалить все данные
    @homyproducts = Homyproduct.order("id")
    @homyproducts.each do |hp|
	    hp.quantity_all_res = 0
	    hp.quantity_all_free = 0
	    hp.quantity_main_res = 0
	    hp.quantity_main_free = 0
	    hp.quantity_tul_res = 0
	    hp.quantity_tul_free = 0
	    hp.quantity_transit_all = 0
	    hp.quantity_transit_free = 0
	    hp.save
	    end
	    
    spreadsheet = open_spreadsheet(file) 
     (5..spreadsheet.last_row).each do |i|  
	     artikul = spreadsheet.cell(i,'A').to_i 
	     title = spreadsheet.cell(i,'B')
	     price_file = spreadsheet.cell(i,'C')
	     valuta = spreadsheet.cell(i,'D')
	     
			if valuta == "РУБ"
			url = "http://www.cbr.ru/scripts/XML_daily.asp"
			data = Nokogiri::XML(open(url))
			a = data.xpath("ValCurs/Valute[@ID = 'R01235']/Value").text
			kurs = a.gsub(/,/, '.')
			price = (price_file.to_f / "#{kurs}".to_f).to_f.round(2) 
			else
			price = price_file.to_f.round(2) 
			end
	     quantity_all_res = spreadsheet.cell(i,'E').to_i 
	     quantity_all_free = spreadsheet.cell(i,'F').to_i
	     quantity_main_res = spreadsheet.cell(i,'G').to_i 
	     quantity_main_free = spreadsheet.cell(i,'H').to_i
	     quantity_tul_res = spreadsheet.cell(i,'I').to_i 
	     quantity_tul_free = spreadsheet.cell(i,'J').to_i
	     quantity_transit_all = spreadsheet.cell(i,'M').to_i
	     quantity_transit_free = spreadsheet.cell(i,'N').to_i
		 #min_price = spreadsheet.cell(i,'O').to_f
		 #sell_price = spreadsheet.cell(i,'P').to_f
		 
      
      @homyproduct = Homyproduct.find_by_artikul("#{artikul}")
		if @homyproduct.present? 
		@homyproduct.update_attributes( :quantity_all_res => quantity_all_res, :quantity_all_free => quantity_all_free, :quantity_main_res => quantity_main_res, :quantity_main_free => quantity_main_free, :quantity_tul_res => quantity_tul_res, :quantity_tul_free => quantity_tul_free, :quantity_transit_all => quantity_transit_all,:quantity_transit_free => quantity_transit_free, :price => price)#:artikul => artikul, :title => title, :price => price, :valuta => valuta,:sell_price => sell_price, :min_price => min_price)
		else
		@homyproduct = Homyproduct.new(:artikul => artikul, :title => title, :price => price, :valuta => valuta, :quantity_all_res => quantity_all_res, :quantity_all_free => quantity_all_free, :quantity_main_res => quantity_main_res, :quantity_main_free => quantity_main_free, :quantity_tul_res => quantity_tul_res, :quantity_tul_free => quantity_tul_free, :quantity_transit_all => quantity_transit_all,:quantity_transit_free => quantity_transit_free)#, :sell_price => sell_price, :min_price => min_price)
 		@homyproduct.save
 		end
		if !@homyproduct.price.nil?
		min_price = (@homyproduct.price * 1.19).to_f.round(2)
		sell_price = (@homyproduct.price * 1.26).to_f.round(2)
		@homyproduct.update_attributes(:sell_price => sell_price, :min_price => min_price)
 		end
       
    end
     
    @homyGrand = Homyproduct.where('title like ?', '%Grandstream%')
 		@homyGrand.each do |hd|
	 		hd.sell_price = (hd.price * 1.20).to_f.round(2)
	 		hd.save
	 		end
	@homyRTX = Homyproduct.where('title like ?', '%RTX%')
 		@homyRTX.each do |hd|
	 		hd.sell_price = (hd.price * 1.40).to_f.round(2)
	 		hd.save
	 		end
	@homyYe = Homyproduct.where('title like ?', '%sip-t%')
 		@homyYe.each do |hd|
	 		hd.sell_price = (hd.price * 1.45).to_f.round(2)
	 		hd.save
	 		end
	@homyDbl = Homyproduct.where('title like ?', '%DBL%')
 		@homyDbl.each do |hd|
	 		hd.sell_price = (hd.price * 1.36).to_f.round(2)
	 		hd.save
	 		end
  end
  
   def self.open_spreadsheet(file)
    case File.extname(file.original_filename)
    when ".csv" then Roo::CSV.new(file.path, csv_options: {col_sep: ";"})
    when ".xls" then Roo::Excel.new(file.path)
    when ".xlsx" then Roo::Excelx.new(file.path)
    when ".XLS" then Roo::Excel.new(file.path)
    else raise "Unknown file type: #{file.original_filename}"
    end
  end
  
end


# Внизу код работающий для csv
# def self.import(file) 
#     CSV.foreach(file.path, headers: true) do |row|
#       Homyproduct.create! row.to_hash
#     end
#   end