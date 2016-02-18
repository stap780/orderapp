class Icr < ActiveRecord::Base

	validates :icr_id, uniqueness: true

	require 'open-uri'
	require 'nokogiri'
	require 'rest-client'
	require 'json'
	
	def self.downloadproduct
	
	page = open('http://store.et-battery.com/api/stores/1/products?items_per_page=500', :http_basic_authentication => ['panaet80@mail.ru','49UCR0Fnc4R95Mahz8oz5sAne099V50o'])
	contents = page.read
	data = JSON.parse(contents)
	h = data["products"]
	h.each do |h|
	@icr = Icr.new
	@icr.icr_id = h["product_id"]
	@icr.title = h["product"]
	@icr.price_usd = h["price"]
	@icr.save
	
	end
	
	end
	
	def self.updateproduct
	@icr = Icr.order("id")
	@icr.each do |icr|
	url = "http://www.cbr.ru/scripts/XML_daily.asp"
	data = Nokogiri::XML(open(url))
	a = data.xpath("ValCurs/Valute[@ID = 'R01235']/Value").text
	kurs = a.gsub(/,/, '.')
	icr.price_rub = icr.price_usd * "#{kurs}".to_f
	icr.save
	end
	
	@icrs = Icr.order("id")
      @icrs.each do |icr|
        uri = "http://panaet80%40mail.ru:49UCR0Fnc4R95Mahz8oz5sAne099V50o@store.et-battery.com/api/stores/1/products/#{(icr.icr_id)}"
        jdata = {:price => "#{(icr.price_rub)}"}.to_json
        response = RestClient.put uri, jdata, :content_type => "application/json" 
      end
      
	
	end
end
