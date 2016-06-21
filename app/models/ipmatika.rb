class Ipmatika < ActiveRecord::Base

has_many :products

validates :title, uniqueness: true

require 'roo'
require 'roo-xls'


def self.to_csv(options = {})
    CSV.generate(options) do |csv|
      csv << column_names
      all.each do |ipmatika|
        csv << ipmatika.attributes.values_at(*column_names)
      end
    end
  end


def self.import(file)
    
    spreadsheet = open_spreadsheet(file) 
     (9..spreadsheet.last_row).each do |i|  
       sku = spreadsheet.cell(i,'A').to_s
       title = spreadsheet.cell(i,'F')
       quantity_all = spreadsheet.cell(i,'Q').to_i
       quantity_free = spreadsheet.cell(i,'Q').to_i
       cost_price = spreadsheet.cell(i,'P').to_f
       price = spreadsheet.cell(i,'N').to_f
       
       @ipmatika = Ipmatika.find_by_sku("#{sku}")
		if @ipmatika.present? 
		@ipmatika.update_attributes( :title => title, :quantity_all => quantity_all, :quantity_free => quantity_free, :cost_price => cost_price, :price => price)
		else
		@ipmatika = Ipmatika.new(:sku => sku, :title => title, :quantity_all => quantity_all, :quantity_free => quantity_free, :cost_price => cost_price, :price => price)
 		@ipmatika.save
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
