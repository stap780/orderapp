class Gstele < ActiveRecord::Base

require 'roo'
require 'roo-xls'
require 'open-uri'


validates :sku, uniqueness: true

  def self.to_csv(options = {})
    CSV.generate(options) do |csv|
      csv << column_names
      all.each do |gstele|
        csv << gstele.attributes.values_at(*column_names)
      end
    end
  end
  
  def self.import(file)
    #Gstele.destroy_all
    @gsteles = Gstele.order("id")
    @gsteles.each do |gs|
	    gs.quantity = 0
	    gs.save
	    end
    spreadsheet = open_spreadsheet(file) 
     (4..spreadsheet.last_row).each do |i|  
	     sku = spreadsheet.cell(i,'A').to_s.gsub('.0','').squish 
	     title = spreadsheet.cell(i,'B')
	     price_euro = spreadsheet.cell(i,'E')
	     valute = spreadsheet.cell(i,'F') 
	     quantity = spreadsheet.cell(i,'C').to_i

		kurs_dollar = Kur.last.dollar
		kurs_euro = Kur.last.euro
		
		price_file = price_euro.to_f * "#{kurs_euro}".to_f / "#{kurs_dollar}".to_f
		cost_price= price_file / 1.15
		price =  price_file / 1.05
      
      @gstele = Gstele.find_by_sku("#{sku}")
		if @gstele.present? 
		@gstele.update_attributes(:quantity => quantity, :price => price, :cost_price => cost_price)#( :price => price, :quantity => quantity, :cost_price => cost_price)
# 		else
# 		@gstele = Gstele.new(:sku => sku, :title => title, :price => price, :valute => valute, :quantity => quantity)
#   		@gstele.save
 		end
       
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
