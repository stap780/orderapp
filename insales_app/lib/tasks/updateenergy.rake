desc "updateenergy"
task :updateenergy => :environment do

require 'mechanize'
require 'nokogiri'
require 'open-uri'
require 'rest-client'


energy = Energy.order("id").limit(10).offset(270)
	agent = Mechanize.new
	agent.robots = false
	agent.user_agent_alias = 'Mac Safari'
	energy.each do |en|
	link = en.image_url
	b = en.sku.gsub(/\W/,'-')
	agent.get(link).save "app/assets/images/et_img/#{b}.jpg"
	end

    
end