class Sskom < ActiveRecord::Base

has_many :products

validates :title, uniqueness: true

require 'roo'
require 'roo-xls'


def self.to_csv(options = {})
    CSV.generate(options) do |csv|
      csv << column_names
      all.each do |sskom|
        csv << sskom.attributes.values_at(*column_names)
      end
    end
  end


def self.import(file)
    
    spreadsheet = open_spreadsheet(file) 
     (6..spreadsheet.last_row).each do |i|  
       sskom = find_by_title(:title) || new
       
       title = spreadsheet.cell(i,'B') 
       quantity = spreadsheet.cell(i,'C')
            
      sskom.update_attributes( :title => title, :quantity => quantity)
      sskom.save
      
          
      sskoms = Sskom.where("title = ?", spreadsheet.cell(i,'B'))
      sskoms.each do |ssk|
      ssk.update_attributes( :title => title, :quantity => quantity)
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
