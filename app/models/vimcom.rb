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
       
       title = spreadsheet.cell(i,'B') 
       quantity = spreadsheet.cell(i,'C')
       if quantity.to_s.length > 0
	      quantity_free = quantity
	      quantity_all = quantity
	      else
	       quantity_free = 0
	       quantity_all = 0
	     end
          
      vimcom = Vimcom.where("title = ?", spreadsheet.cell(i,'B'))
      if vimcom.present? 
      vimcom.each do |vim|
      vim.update_attributes(  :quantity_all => quantity_all, :quantity_free => quantity_free)
      end
      else
      vimcom = Vimcom.new( :title => title, :quantity_all => quantity_all, :quantity_free => quantity_free)
      vimcom.save
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
