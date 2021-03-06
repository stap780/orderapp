class Car < ActiveRecord::Base
	
validates :title, uniqueness: true

require 'open-uri'
require 'nokogiri'
require 'rest-client'
require 'json'
require 'roo'
require 'roo-xls'
require 'net/http'

	 def self.import(file)
# 		 Car.destroy_all
	    spreadsheet = open_spreadsheet(file) 
		    (2..spreadsheet.last_row).each do |i|  
		       
		       #webid = spreadsheet.cell(i,'B') 
		       title = spreadsheet.cell(i,'A')
		       url = spreadsheet.cell(i,'K')[16..-1]
		      car = Car.where("title = ?", "#{title}")
		      if car.present? 
			      car.each do |car|
			      car.update_attributes(  :url => url)
			      end
# 			    else
# 			      car = Car.new( :title => title)
# 			      car.save
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

	def self.webidupdate
		url = 'https://car812.webasyst.cloud/yandexmarket/e7e30d06-f550-4fa5-b663-0de4046bbb4c.xml'
# 		response = RestClient.get 'https://car812.webasyst.cloud/yandexmarket/e7e30d06-f550-4fa5-b663-0de4046bbb4c.xml'
# 		data = Nokogiri::XML(response) 
data = Nokogiri::XML(open(url))
		offers = data.xpath("//shop/offers/offer")
			offers.each do |offer|
				webid = offer["id"]
				title = offer.css("name").text
				@car = Car.where("title = ?",offer.css("name").text)
					if @car.present?
					@car.each do |car|
					car.update_attributes(:webid => webid)
					end
					end
			end
	end
	
		def self.uploadurl
		cars = Car.order("id")
		cars.each do |car|
		uri = URI('http://car812.webasyst.cloud/api.php/shop.product.update?id='+"#{car.webid}"+'&access_token=9157b0cecb48c12001e0bc72996aa6cd')
		res = Net::HTTP.post_form(uri, {'url'=> "#{car.url}"} )
		end
		end
# 	r = RestClient.get('http://car812.webasyst.cloud/api.php/shop.product.getInfo', params: {id: '413', access_token: '9157b0cecb48c12001e0bc72996aa6cd'})
# 	9157b0cecb48c12001e0bc72996aa6cd
end
