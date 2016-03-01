class Angel < ActiveRecord::Base
has_many :products

validates :sku, uniqueness: true

require 'roo'
require 'roo-xls'


def self.to_csv(options = {})
    CSV.generate(options) do |csv|
      csv << column_names
      all.each do |angel|
        csv << angel.attributes.values_at(*column_names)
      end
    end
  end


def self.import(file)
    
    spreadsheet = open_spreadsheet(file) 
     (5..spreadsheet.last_row).each do |i|  
       angel = find_by_sku(:sku) || new
       sku = spreadsheet.cell(i,'A').to_i 
       title = spreadsheet.cell(i,'B')
       quantity = spreadsheet.cell(i,'F')
       status = spreadsheet.cell(i,'G')
       valuta = spreadsheet.cell(i,'H')
       price = spreadsheet.cell(i,'I')
       cost_price = spreadsheet.cell(i,'J') 
       
      
      angel.update_attributes(:sku => sku, :title => title, :quantity => quantity, :status => status, :valuta => valuta, :price => price, :cost_price => cost_price )
      angel.save
      
          
      angels = Angel.where("cast(sku as integer) = ?", spreadsheet.cell(i,'A').to_i)
      angels.each do |an|
      an.update_attributes(:sku => sku, :title => title, :quantity => quantity, :status => status, :valuta => valuta, :price => price, :cost_price => cost_price )
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

end
