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
     (8..spreadsheet.last_row).each do |i|  
       ipmatika = find_by_title(:title) || new
       
       title = spreadsheet.cell(i,'A')
       quantity_all = spreadsheet.cell(i,'E').to_i
       quantity_res = spreadsheet.cell(i,'G').to_i
       quantity_free = spreadsheet.cell(i,'F').to_i
      
       
      
      ipmatika.update_attributes( :title => title, :quantity_all => quantity_all, :quantity_res => quantity_res, :quantity_free => quantity_free)
      ipmatika.save
      
          
      ipmatikas = Ipmatika.where("title = ?", spreadsheet.cell(i,'A'))
      ipmatikas.each do |ip|
      ip.update_attributes( :title => title, :quantity_all => quantity_all, :quantity_res => quantity_res, :quantity_free => quantity_free)
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
