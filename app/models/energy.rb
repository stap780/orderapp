class Energy < ActiveRecord::Base
  
  has_many :products
  validates :sku, uniqueness: true
  
  require 'open-uri'
  require 'mechanize'
  require 'roo'
  require 'roo-xls'
  
  def self.to_csv(options = {})
    CSV.generate(options) do |csv|
      csv << column_names
      all.each do |et|
        csv << et.attributes.values_at(*column_names)
      end
    end
  end
  
  def self.updateproduct
  # @products = Product.order("sku")
# 	@products.each do |p|
#   	mysku = p.sku
#   	myq = p.quantity
#   	@energies = Energy.where("sku = ?", mysku)
#   	@energies.each do  |e|
#     	e.quantity = myq
#     	e.save
#   	end
# 	end

#require 'open-uri'
@energies = Energy.order("id").offset(240)
@energies.each do |en|
link = en.image_url
b = en.sku.gsub(/\W/,'-')
download = open(link)
IO.copy_stream(download, "app/assets/images/et_img/#{b}.jpg")
end
	
	# @energies = Energy.order("id").limit(10).offset(270)
# 	agent = Mechanize.new
# 	agent.robots = false
# 	agent.user_agent_alias = 'Mac Safari'
# 	@energies.each do |en|
# 	link = en.image_url
# 	b = en.sku.gsub(/\W/,'-')
# 	agent.get(link).save "app/assets/images/et_img/#{b}.jpg"
# 	end
  end
  
  def self.import(file)
   
    spreadsheet = open_spreadsheet(file) 
     (2..spreadsheet.last_row).each do |i|  
       energy = find_by_sku(:sku) || new
       sku = spreadsheet.cell(i,'A') 
       title = spreadsheet.cell(i,'B')
       quantity = spreadsheet.cell(i,'C')
       cost_price = spreadsheet.cell(i,'D') 
       price = spreadsheet.cell(i,'E')
       short_description = spreadsheet.cell(i,'F')
       description = spreadsheet.cell(i,'G')
       image_url = spreadsheet.cell(i,'H')       
      
      energy.update_attributes(:sku => sku, :title => title, :quantity => quantity, :price => price, :cost_price => cost_price, :short_description => short_description, :description => description, :image_url => image_url )
      energy.save
      
          
      energies = Energy.where("sku = ?", spreadsheet.cell(i,'A'))
      energies.each do |et|
      et.update_attributes(:sku => sku, :title => title, :quantity => quantity, :price => price, :cost_price => cost_price, :short_description => short_description, :description => description, :image_url => image_url )
      end
       
    end
  end
  
   def self.open_spreadsheet(file)
    case File.extname(file.original_filename)
    when ".csv" then Roo::CSV.new(file.path,csv_options: {encoding: Encoding::UTF_8})
    when ".xls" then Roo::Excel.new(file.path)
    when ".xlsx" then Roo::Excelx.new(file.path)
    when ".XLS" then Roo::Excel.new(file.path)
    else raise "Unknown file type: #{file.original_filename}"
    end
  end
  
end
