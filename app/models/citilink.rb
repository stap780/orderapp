# encoding: utf-8
class Citilink < ActiveRecord::Base
has_many :products
validates :title, uniqueness: true


require 'mechanize'
require 'nokogiri'
require 'open-uri'

def self.downloadproduct
		@citilinks = Citilink.order("id")
		@citilinks.each do |ct|
		ct.q1 = 0
		ct.q2 = 0
		ct.q3 = 0
		ct.q4 = 0
		ct.q5 = 0
		ct.save
		end
# 		//*[@id="subcategoryList"]/div[1]/div/div[4]/div[2]/div[1]/span[1]/span/ins[1]
# 		//*[@id="subcategoryList"]/div[1]/div/div[4]/div[2]/div[1]/span[2]/span/ins[1]
# 		//*[@id="subcategoryList"]/div[1]/div/div[5]/div[2]/div[1]/span/span/ins[1]
	
	a = Mechanize.new
	mypage = a.get("http://www.citilink.ru/catalog/furniture/phones/phones_ip/?available=1&status=55395790&p=1")	
	
  products = mypage.css(".subcategory-product-item")
	products.each do|pr|
	title = pr.xpath('./div[1]/div[2]/span/a').attr('title')
	cid = pr.xpath('./div[1]/div[2]/span/a').attr("data-product-id")
	price_ct = pr.xpath('./div[2]/div[1]/span[2]/span/ins[1]').text.gsub(/ /, '').gsub(/\n/,'')
	price1_ct = pr.xpath('./div[2]/div[1]/span/span/ins[1]').text.gsub(/ /, '').gsub(/\n/,'')
	if price_ct != ''
	price = price_ct.to_f / Kur.last.dollar
	price1 = (price.to_f * 1.17).to_f 
	else
	price = price1_ct.to_f / Kur.last.dollar
	price1 = (price.to_f * 1.13).to_f 
	end
	q1 = pr.xpath('./div[1]/div[2]/div[2]/span[1]/span').text.gsub(/много/, '10').gsub(/^$/,'0')
	q2 = pr.xpath('./div[1]/div[2]/div[2]/span[2]/span').text.gsub(/много/, '10').gsub(/^$/,'0')
	q3 = pr.xpath('./div[1]/div[2]/div[2]/span[3]/span').text.gsub(/много/, '10').gsub(/^$/,'0')	
	q4 = pr.xpath('./div[1]/div[2]/div[2]/span[4]/span').text.gsub(/много/, '10').gsub(/^$/,'0')			
	q5 = pr.xpath('./div[1]/div[2]/div[2]/span[5]/span').text.gsub(/много/, '20').gsub(/^$/,'0')
	@citilink = Citilink.find_by_cid("#{cid}")
		if @citilink.nil?	
		@citilink = Citilink.new(:title => title, :cid => cid, :price => price, :price1 => price1, :q1 => q1, :q2 => q2, :q3 => q3, :q4 => q4, :q5 => q5)
		@citilink.save
		else
		@citilink.update_attributes( :price => price, :price1 => price1, :q1 => q1, :q2 => q2, :q3 => q3, :q4 => q4, :q5 => q5)
		end
	end
	
	mypage = a.get("http://www.citilink.ru/catalog/furniture/phones/phones_ip/?available=1&status=55395790&p=2")	
  products = mypage.css(".subcategory-product-item")
	products.each do|pr|
	title = pr.xpath('./div[1]/div[2]/span/a').attr('title')
	cid = pr.xpath('./div[1]/div[2]/span/a').attr("data-product-id")
	price_ct = pr.xpath('./div[2]/div[1]/span[2]/span/ins[1]').text.gsub(/ /, '').gsub(/\n/,'')
	price1_ct = pr.xpath('./div[2]/div[1]/span/span/ins[1]').text.gsub(/ /, '').gsub(/\n/,'')
	if price_ct != ''
	price = price_ct.to_f / Kur.last.dollar
	price1 = (price.to_f * 1.17).to_f 
	else
	price = price1_ct.to_f / Kur.last.dollar
	price1 = (price.to_f * 1.13).to_f 
	end
	q1 = pr.xpath('./div[1]/div[2]/div[2]/span[1]/span').text.gsub(/много/, '10').gsub(/^$/,'0')
	q2 = pr.xpath('./div[1]/div[2]/div[2]/span[2]/span').text.gsub(/много/, '10').gsub(/^$/,'0')
	q3 = pr.xpath('./div[1]/div[2]/div[2]/span[3]/span').text.gsub(/много/, '10').gsub(/^$/,'0')	
	q4 = pr.xpath('./div[1]/div[2]/div[2]/span[4]/span').text.gsub(/много/, '10').gsub(/^$/,'0')			
	q5 = pr.xpath('./div[1]/div[2]/div[2]/span[5]/span').text.gsub(/много/, '20').gsub(/^$/,'0')
	@citilink = Citilink.find_by_cid("#{cid}")
		if @citilink.nil?	
		@citilink = Citilink.new(:title => title, :cid => cid, :price => price, :price1 => price1, :q1 => q1, :q2 => q2, :q3 => q3, :q4 => q4, :q5 => q5)
		@citilink.save
		else
		@citilink.update_attributes( :price => price, :price1 => price1, :q1 => q1, :q2 => q2, :q3 => q3, :q4 => q4, :q5 => q5)
		end
	end
	
	@citilink = Citilink.order("id")
 	@citilink.each do |c|
	 	c.quantity = c.q1.to_i + c.q2.to_i + c.q3.to_i + c.q4.to_i + c.q5.to_i
 	c.save
 	end

end

def self.updateproduct

end


end
