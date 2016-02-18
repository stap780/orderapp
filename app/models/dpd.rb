class Dpd < ActiveRecord::Base

	validates :numer, uniqueness: true

	has_many :iorders
	
	require 'savon'
	
	
	def self.updatedpd
	@dpds = Dpd.order("numer")
	@dpds.each do |dpd|
	
	client = Savon.client(wsdl: "http://ws.dpd.ru:80/services/tracing1-1?wsdl")
	
	response = client.call(:get_states_by_client_order, message: { request: { auth:{clientNumber: "1001031371", clientKey: "DDCEEA16D6A7BBAF6B2C276E4292B53942766CC1"}, clientOrderNr: "#{dpd.numer}"}})
	
	data = response.body
	
	states = data[:get_states_by_client_order_response][ :return][:states].to_a
	
	dpd.dpdnumber = states[0][:dpd_order_nr]
	dpd.pickupdate = states[0][:pickup_date]
	dpd.plandeliverytime = states[0][:plan_delivery_date]
	dpd.state = states.last[:new_state]
	dpd.save
	end	
	end

end
