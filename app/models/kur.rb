class Kur < ActiveRecord::Base
	
	require 'open-uri'
	
	validates :date, uniqueness: true
	
	def self.updatekurs
	url = "http://www.cbr.ru/scripts/XML_daily.asp"
	data = Nokogiri::XML(open(url))
	a = data.xpath("ValCurs/Valute[@ID = 'R01235']/Value").text
	kurs_dollar = a.gsub(/,/, '.').to_f
	b = data.xpath("ValCurs/Valute[@ID = 'R01239']/Value").text
	kurs_euro = b.gsub(/,/, '.').to_f
	date = data.xpath("ValCurs").first["Date"]
	
	a = date.to_time.in_time_zone('Moscow') +10.minutes
		
	@kur = Kur.where('date BETWEEN ? AND ?', a.beginning_of_day,  a.end_of_day).last
	if @kur.nil?
		Kur.create(:date => date, :dollar => kurs_dollar, :euro => kurs_euro)	
		else	
		@kur.update_attributes(:dollar => kurs_dollar, :euro => kurs_euro)
	end
	
	end
	
	
end
