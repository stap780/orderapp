class Dpd < ActiveRecord::Base

	validates :numer, uniqueness: true

	has_many :iorders
	
	require 'savon'
	
	def self.updatedpd
	@dpds = Dpd.order("id desc").limit(5)
	@dpds.each do |dpd|
	
	client = Savon.client(wsdl: "http://ws.dpd.ru:80/services/tracing1-1?wsdl")
	
	response = client.call(:get_states_by_client_order, message: { request: { auth:{clientNumber: "1001031371", clientKey: "DDCEEA16D6A7BBAF6B2C276E4292B53942766CC1"}, clientOrderNr: "#{dpd.numer}"}})
	
	data = response.body
	
	mystates = data[:get_states_by_client_order_response][ :return][:states]
	states = mystates.last
	
	dpd.dpdnumber = states[:dpd_order_nr]
	dpd.pickupdate = states[:pickup_date]
	dpd.plandeliverytime = states[:plan_delivery_date]
	dpd.state = states[:new_state]
		
	dpd.save
	end	
	end

end
