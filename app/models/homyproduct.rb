class Homyproduct < ActiveRecord::Base

has_many :products

require 'roo'
require 'roo-xls'

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
    
    spreadsheet = open_spreadsheet(file) 
     (5..spreadsheet.last_row).each do |i|  
       homyproduct = find_by_artikul(:artikul) || new
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
	     quantity_transit_all = spreadsheet.cell(i,'M').to_i
	     quantity_transit_free = spreadsheet.cell(i,'N').to_i
      
      homyproduct.update_attributes(:artikul => artikul, :title => title, :price => price, :valuta => valuta, :quantity_all_res => quantity_all_res, :quantity_all_free => quantity_all_free, :quantity_main_res => quantity_main_res, :quantity_main_free => quantity_main_free, :quantity_tul_res => quantity_tul_res, :quantity_tul_free => quantity_tul_free, :quantity_transit_all => quantity_transit_all,:quantity_transit_free => quantity_transit_free)
      homyproduct.save
      
          
      homyproducts = Homyproduct.where("cast(artikul as integer) = ?", spreadsheet.cell(i,'A').to_i)
      homyproducts.each do |hp|
      hp.update_attributes(:artikul => artikul, :title => title, :price => price, :valuta => valuta, :quantity_all_res => quantity_all_res, :quantity_all_free => quantity_all_free, :quantity_main_res => quantity_main_res, :quantity_main_free => quantity_main_free, :quantity_tul_res => quantity_tul_res, :quantity_tul_free => quantity_tul_free, :quantity_transit_all => quantity_transit_all,:quantity_transit_free => quantity_transit_free)
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


# Внизу код работающий для csv
# def self.import(file) 
#     CSV.foreach(file.path, headers: true) do |row|
#       Homyproduct.create! row.to_hash
#     end
#   end