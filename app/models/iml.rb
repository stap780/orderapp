class Iml < ActiveRecord::Base

validates :number, uniqueness: true

	has_many :iorders
	
require 'open-uri'
require 'nokogiri'
require 'rest-client'
require 'json'


	def self.updateiml
	@imls = Iml.order("id desc").limit(15)
	@imls.each do |iml|
	response = RestClient.post "http://03584:uK8$o$iC@api.iml.ru/json/GetStatuses", { 'CustomerOrder' => "#{(iml.number)}" }.to_json, :content_type => :json, :accept => :json

	data = JSON.parse(response)
	b = data[0]
	
	
	iml.statenum = b["State"]
	iml.state = b["StateDescription"]
	iml.statusnum = b["OrderStatus"]
	iml.status = b["OrderStatusDescription"]
	iml.statusdate = b["StatusDate"]
	iml.barcode = b["BarCode"]
	
	iml.save
	
	end	
	end

end
