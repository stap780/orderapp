class Ipmatika < ActiveRecord::Base

has_many :products

validates :sku, uniqueness: true

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
    @ipmatikas= Ipmatika.order("id")
    @ipmatikas.each do |ipm|
	    ipm.quantity_all = 0
	    ipm.quantity_free = 0
	    ipm.save
	  end
    spreadsheet = open_spreadsheet(file) 
     (9..spreadsheet.last_row).each do |i|  
       sku = spreadsheet.cell(i,'A').to_s
       title = spreadsheet.cell(i,'E').to_s
       quantity_all = spreadsheet.cell(i,'Q').to_i
       quantity_free = spreadsheet.cell(i,'Q').to_i
       cost_price = spreadsheet.cell(i,'P').to_f
       price = spreadsheet.cell(i,'N').to_f
       #puts "#{(sku)}"
        ipmatika = Ipmatika.find_by_sku(sku)
				if !ipmatika.present? 
				ipmatika = Ipmatika.new(:sku => sku, :title => title, :quantity_all => quantity_all, :quantity_free => quantity_free, :cost_price => cost_price, :price => price)
				ipmatika.save
		 		else
				ipmatika.update_attributes( :title => title, :quantity_all => quantity_all, :quantity_free => quantity_free, :cost_price => cost_price, :price => price)
		    end
    end
    ipmatika = Ipmatika.where('sku Like ?', '%SIP%')
		ipmatika.each do |v|
			koef = 1.03 # коэффициент 
			new_cost_price = (v.cost_price*koef).to_f.round(2)
			new_price = (v.price*koef).to_f.round(2)
			v.update_attributes(:cost_price => new_cost_price, :price => new_price)
		end
		ipmatika = Ipmatika.where('sku Like ?', '%W5%')
		ipmatika.each do |v|
			koef = 1.03
			new_cost_price = (v.cost_price*koef).to_f.round(2)
			new_price = (v.price*koef).to_f.round(2)
			v.update_attributes(:cost_price => new_cost_price, :price => new_price)
		end
		ipmatika = Ipmatika.where('sku Like ?', '%VP530%')
		ipmatika.each do |v|
			koef = 1.03
			new_cost_price = (v.cost_price*koef).to_f.round(2)
			new_price = (v.price*koef).to_f.round(2)
			v.update_attributes(:cost_price => new_cost_price, :price => new_price)
		end
		ipmatika = Ipmatika.where('sku Like ?', '%CP860%')
		ipmatika.each do |v|
			koef = 1.03
			new_cost_price = (v.cost_price*koef).to_f.round(2)
			new_price = (v.price*koef).to_f.round(2)
			v.update_attributes(:cost_price => new_cost_price, :price => new_price)
		end
		ipmatika = Ipmatika.where('sku Like ?', '%EXP%')
		ipmatika.each do |v|
			koef = 1.03
			new_cost_price = (v.cost_price*koef).to_f.round(2)
			new_price = (v.price*koef).to_f.round(2)
			v.update_attributes(:cost_price => new_cost_price, :price => new_price)
		end
		ipmatika = Ipmatika.where('sku Like ?', '%5VDC%')
		ipmatika.each do |v|
			koef = 1.03
			new_cost_price = (v.cost_price*koef).to_f.round(2)
			new_price = (v.price*koef).to_f.round(2)
			v.update_attributes(:cost_price => new_cost_price, :price => new_price)
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
