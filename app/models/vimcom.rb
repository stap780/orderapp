class Vimcom < ActiveRecord::Base

has_many :products

validates :title, uniqueness: true

require 'roo'
require 'roo-xls'


def self.to_csv(options = {})
    CSV.generate(options) do |csv|
      csv << column_names
      all.each do |vimcom|
        csv << vimcom.attributes.values_at(*column_names)
      end
    end
  end


def self.import(file)
    @vimcoms = Vimcom.order("id")
    @vimcoms.each do |v|
	    v.quantity_free = 0
	    v.quantity_all = 0
	    v.save
	    end
    spreadsheet = open_spreadsheet(file) 
     (1..spreadsheet.last_row).each do |i|  
#        vimcom = find_by_title(:title) || new
       
       title = spreadsheet.cell(i,'B') 
       quantity_free = spreadsheet.cell(i,'C')
       quantity_all = spreadsheet.cell(i,'C')
       
      
#       vimcom.update_attributes( :title => title, :quantity_all => quantity_all, :quantity_free => quantity_free)
#       vimcom.save
      
          
      vimcoms = Vimcom.where("title = ?", spreadsheet.cell(i,'B'))
      vimcoms.each do |vim|
      vim.update_attributes( :title => title, :quantity_all => quantity_all, :quantity_free => quantity_free)
      end
       
    end
  end
  
   def self.open_spreadsheet(file)
    case File.extname(file.original_filename)
    when ".csv" then Roo::Csv.new(file.path, csv_options: {col_sep: ","})
    when ".xls" then Roo::Excel.new(file.path)
    when ".xlsx" then Roo::Excelx.new(file.path)
    when ".XLS" then Roo::Excel.new(file.path)
    else raise "Unknown file type: #{file.original_filename}"
    end
  end


end
