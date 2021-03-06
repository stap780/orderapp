class Angel < ActiveRecord::Base
has_many :products

validates :title, uniqueness: true

require 'roo'
require 'roo-xls'
require 'open-uri'


def self.to_csv(options = {})
    CSV.generate(options) do |csv|
      csv << column_names
      all.each do |angel|
        csv << angel.attributes.values_at(*column_names)
      end
    end
  end


def self.import(file)
    @angels = Angel.order("id")
    @angels.each do |a|
	    a.quantity = 0
	    a.save
	    end
	    
	    
	    
    spreadsheet = open_spreadsheet(file) 
    
    
     (10..spreadsheet.last_row).each do |i|  
#        angel = find_by_title(:title) || new
       sku = spreadsheet.cell(i,'A').to_s.gsub('.0','') 
       title = spreadsheet.cell(i,'B').to_s 
       quantity_file = spreadsheet.cell(i,'C')
       if quantity_file.nil?
	       quantity = 0
	       else
	       quantity = quantity_file
	       end
       #status = spreadsheet.cell(i,'G')
       cost_price_usd = spreadsheet.cell(i,'F') 
       price_file = spreadsheet.cell(i,'D')
       valuta1 = spreadsheet.cell(i,'E')
       valuta2 = spreadsheet.cell(i,'G')
         
		    if valuta1 == "RUB"
			    if price_file < 900
						price = ((price_file.to_f / Kur.last.dollar.to_f) * 1.15).to_f.round(2)
					else
						price = (price_file.to_f / Kur.last.dollar.to_f).to_f.round(2)
					end	
				else
					if price_file < 13
						price = (price_file.to_f * 1.15).round(2)
					else
						price = price_file.to_f.round(2)
					end
				end
				if valuta2 == "RUB"
				cost_price = (cost_price_usd.to_f / Kur.last.dollar.to_f).to_f.round(2)
				else
				cost_price =  cost_price_usd.to_f.round(2)
				end
       
       
#       angel = Angel.find_by_title("#{title}")
#       puts "#{angel.title}"
#       angel.update_attributes(:sku => sku, :quantity => quantity, :valuta => valuta, :price => price, :cost_price => cost_price )#, :status => status
#       angel.save
		angel = Angel.find_by_title("#{title}")
		if angel.present? 
		angel.update_attributes(:sku => sku, :quantity => quantity, :valuta => valuta1, :price => price, :cost_price => cost_price )#, :status => status
		else
		angel = Angel.new( :sku => sku, :title => title, :quantity => quantity, :valuta => valuta1, :price => price, :cost_price => cost_price)
		angel.save
		end
          
#       angels = Angel.where("cast(sku as integer) = ?", spreadsheet.cell(i,'A').to_i)
#       angels.each do |an|
#       an.update_attributes(:sku => sku, :quantity => quantity, :valuta => valuta, :price => price, :cost_price => cost_price )#, :status => status
#       end
       
    end
   
   @angels = Angel.where('title Like ?', '%Vigor%')
   @angels.each do |ang|
	   ang.price = ang.cost_price * 1.10
	   ang.save
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

end
