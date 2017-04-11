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
	  header = spreadsheet.row(4)
	     
	  (7..spreadsheet.last_row).each do |i|
		     
    row = Hash[[header, spreadsheet.row(i)].transpose]
	     sku = row["Артикул"]
	     title = row["Номенклатура, Упаковка"]
	     quantity_all = row["Остаток"]
	     quantity_free = row["Остаток"]
	     cost_price = row["Дилерская"]#.gsub(',',' ')
	     price = row["Розничная"]#.gsub(',',' ')
				if sku && title !=''
				ipmatika = Ipmatika.find_by_sku(sku)
				if !ipmatika.present? 
				ipmatika = Ipmatika.new(:sku => sku, :title => title, :quantity_all => quantity_all, :quantity_free => quantity_free, :cost_price => cost_price, :price => price)
				ipmatika.save
				else
				ipmatika.update_attributes( :title => title, :quantity_all => quantity_all, :quantity_free => quantity_free, :cost_price => cost_price, :price => price) 
				end
		   end
    end


    k_ipmatika = 58.71
    koef = k_ipmatika/Kur.last.dollar#1.061 # коэффициент
    ipmatika = Ipmatika.where('sku Like ?', '%SIP%')
		ipmatika.each do |v|
			new_cost_price = (v.cost_price*koef).to_f.round(2)
			new_price = (v.price*koef).to_f.round(2)
			v.update_attributes(:cost_price => new_cost_price, :price => new_price)
		end
		ipmatika = Ipmatika.where('sku Like ?', '%W5%')
		ipmatika.each do |v|
			new_cost_price = (v.cost_price*koef).to_f.round(2)
			new_price = (v.price*koef).to_f.round(2)
			v.update_attributes(:cost_price => new_cost_price, :price => new_price)
		end
		ipmatika = Ipmatika.where('sku Like ?', '%VP530%')
		ipmatika.each do |v|
			new_cost_price = (v.cost_price*koef).to_f.round(2)
			new_price = (v.price*koef).to_f.round(2)
			v.update_attributes(:cost_price => new_cost_price, :price => new_price)
		end
		ipmatika = Ipmatika.where('sku Like ?', '%CP860%')
		ipmatika.each do |v|
			new_cost_price = (v.cost_price*koef).to_f.round(2)
			new_price = (v.price*koef).to_f.round(2)
			v.update_attributes(:cost_price => new_cost_price, :price => new_price)
		end
		ipmatika = Ipmatika.where('sku Like ?', '%EXP%')
		ipmatika.each do |v|
			new_cost_price = (v.cost_price*koef).to_f.round(2)
			new_price = (v.price*koef).to_f.round(2)
			v.update_attributes(:cost_price => new_cost_price, :price => new_price)
		end
		ipmatika = Ipmatika.where('sku Like ?', '%5VDC%')
		ipmatika.each do |v|
			new_cost_price = (v.cost_price*koef).to_f.round(2)
			new_price = (v.price*koef).to_f.round(2)
			v.update_attributes(:cost_price => new_cost_price, :price => new_price)
		end
		ipmatika = Ipmatika.where('sku Like ?', '%EHS36%')
		ipmatika.each do |v|
			new_cost_price = (v.cost_price*koef).to_f.round(2)
			new_price = (v.price*koef).to_f.round(2)
			v.update_attributes(:cost_price => new_cost_price, :price => new_price)
		end
		ipmatika = Ipmatika.where('sku Like ?', '%RT10%')
		ipmatika.each do |v|
			new_cost_price = (v.cost_price*koef).to_f.round(2)
			new_price = (v.price*koef).to_f.round(2)
			v.update_attributes(:cost_price => new_cost_price, :price => new_price)
		end
		ipmatika = Ipmatika.where('sku Like ?', '%BT40%')
		ipmatika.each do |v|
			new_cost_price = (v.cost_price*koef).to_f.round(2)
			new_price = (v.price*koef).to_f.round(2)
			v.update_attributes(:cost_price => new_cost_price, :price => new_price)
		end
		ipmatika = Ipmatika.where('sku Like ?', '%YHS32%')
		ipmatika.each do |v|
			new_cost_price = (v.cost_price*koef).to_f.round(2)
			new_price = (v.price*koef).to_f.round(2)
			v.update_attributes(:cost_price => new_cost_price, :price => new_price)
		end
		ipmatika = Ipmatika.where('sku Like ?', '%MS-%')
		ipmatika.each do |v|
			new_price = (v.price*0.95).to_f.round(2) if v.price != nil
			v.update_attributes(:price => new_price)
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
