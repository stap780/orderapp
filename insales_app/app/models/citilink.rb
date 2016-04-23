#!/bin/env ruby
# encoding: utf-8

class Citilink < ActiveRecord::Base
has_many :products
validates :title, uniqueness: true


require 'mechanize'
require 'nokogiri'
require 'open-uri'

def self.downloadproduct
	a = Mechanize.new
	mypage = a.get("http://www.citilink.ru/catalog/furniture/phones/phones_ip/?available=0&status=0&p=1&f=737_64GIGASET,737_64PANASONIC")
	
	
	product = mypage.search('#subcategoryList > div.product_category_list > table > tbody')
	product.each do|pr|
	@citilink = Citilink.new
	@citilink.title = pr.search('tr:nth-child(1) > td.product_name.cms_item_panel > span > a').text
	@citilink.price = pr.search('tr:nth-child(2) > td.prices_container > div > span.standart > span > ins.num').text.gsub(/ /, '')
	@citilink.price1 = pr.search('tr:nth-child(2) > td.prices_container > div > span.special > span  > ins.num').text.gsub(/ /, '')
	@citilink.q1 = pr.search('tr:nth-child(1) > td.product_name.cms_item_panel > div.in_stock_horizontal_position > span:nth-child(1) > span').text.gsub(/много/, '20').gsub(/^$/,'0')
	
	@citilink.q2 = pr.search('tr:nth-child(1) > td.product_name.cms_item_panel > div.in_stock_horizontal_position > span:nth-child(2) > span').text.gsub(/много/, '20').gsub(/^$/,'0')
	@citilink.q3 = pr.search('tr:nth-child(1) > td.product_name.cms_item_panel > div.in_stock_horizontal_position > span:nth-child(3) > span').text.gsub(/много/, '20').gsub(/^$/,'0')	
	@citilink.q4 = pr.search('tr:nth-child(1) > td.product_name.cms_item_panel > div.in_stock_horizontal_position > span:nth-child(4) > span').text.gsub(/много/, '20').gsub(/^$/,'0')			
	@citilink.q5 = pr.search('tr:nth-child(1) > td.product_name.cms_item_panel > div.in_stock_horizontal_position > span:nth-child(6) > span').text.gsub(/много/, '20').gsub(/^$/,'0')	
	@citilink.save
	end
	mypage = a.get("http://www.citilink.ru/catalog/furniture/phones/phones_ip/?available=0&status=0&p=2&f=737_64GIGASET,737_64PANASONIC")
	product = mypage.search('#subcategoryList > div.product_category_list > table > tbody')
	product.each do|pr|
	@citilink = Citilink.new
	@citilink.title = pr.search('tr:nth-child(1) > td.product_name.cms_item_panel > span > a').text
	@citilink.price = pr.search('tr:nth-child(2) > td.prices_container > div > span.standart > span > ins.num').text.gsub(/ /, '')
	@citilink.price1 = pr.search('tr:nth-child(2) > td.prices_container > div > span.special > span  > ins.num').text.gsub(/ /, '')
	
	@citilink.q1 = pr.search('tr:nth-child(1) > td.product_name.cms_item_panel > div.in_stock_horizontal_position > span:nth-child(1) > span').text.gsub(/много/, '20').gsub(/^$/,'0')
				
	@citilink.q2 = pr.search('tr:nth-child(1) > td.product_name.cms_item_panel > div.in_stock_horizontal_position > span:nth-child(2) > span').text.gsub(/много/, '20').gsub(/^$/,'0')			
	@citilink.q3 = pr.search('tr:nth-child(1) > td.product_name.cms_item_panel > div.in_stock_horizontal_position > span:nth-child(3) > span').text.gsub(/много/, '20').gsub(/^$/,'0')			
	@citilink.q4 = pr.search('tr:nth-child(1) > td.product_name.cms_item_panel > div.in_stock_horizontal_position > span:nth-child(4) > span').text.gsub(/много/, '20').gsub(/^$/,'0')			
	@citilink.q5 = pr.search('tr:nth-child(1) > td.product_name.cms_item_panel > div.in_stock_horizontal_position > span:nth-child(6) > span').text.gsub(/много/, '20').gsub(/^$/,'0')	
	@citilink.save
	end
end

def self.updateproduct
	a = Mechanize.new
	mypage = a.get("http://www.citilink.ru/catalog/furniture/phones/phones_ip/?available=0&status=0&p=1&f=737_64GIGASET,737_64PANASONIC")
	#mypage = Nokogiri::HTML(open("http://www.citilink.ru/catalog/furniture/phones/phones_ip/?available=1&p=1"))
	
	@citilink = mypage.search('#subcategoryList > div.product_category_list > table > tbody')
	@citilink.each do|pr|
	@citilinks = Citilink.where("title = ?",pr.search('tr:nth-child(1) > td.product_name.cms_item_panel > span > a').text)
	
	price = pr.search('tr:nth-child(2) > td.prices_container > div > span.standart > span > ins.num').text.gsub(/ /, '')
	price1 = pr.search('tr:nth-child(2) > td.prices_container > div > span.special > span  > ins.num').text.gsub(/ /, '')
	q1 = pr.search('tr:nth-child(1) > td.product_name.cms_item_panel > div.in_stock_horizontal_position > span:nth-child(1) > span').text.gsub(/много/, '20').gsub(/^$/,'0')
	q2 = pr.search('tr:nth-child(1) > td.product_name.cms_item_panel > div.in_stock_horizontal_position > span:nth-child(2) > span').text.gsub(/много/, '20').gsub(/^$/,'0')
	q3 = pr.search('tr:nth-child(1) > td.product_name.cms_item_panel > div.in_stock_horizontal_position > span:nth-child(3) > span').text.gsub(/много/, '20').gsub(/^$/,'0')
	q4 = pr.search('tr:nth-child(1) > td.product_name.cms_item_panel > div.in_stock_horizontal_position > span:nth-child(4) > span').text.gsub(/много/, '20').gsub(/^$/,'0')
	q5 = pr.search('tr:nth-child(1) > td.product_name.cms_item_panel > div.in_stock_horizontal_position > span:nth-child(6) > span').text.gsub(/много/, '20').gsub(/^$/,'0')
	
	@citilinks.each do |c|
	c.update_attributes( :price => price, :price1 => price1, :q1 => q1, :q2 => q2, :q3 => q3, :q4 => q4, :q5 => q5)
	end
	end
	mypage = a.get("http://www.citilink.ru/catalog/furniture/phones/phones_ip/?available=0&status=0&p=2&f=737_64GIGASET,737_64PANASONIC")
	@citilink = mypage.search('#subcategoryList > div.product_category_list > table > tbody')
	@citilink.each do|pr|
	@citilinks = Citilink.where("title = ?",pr.search('tr:nth-child(1) > td.product_name.cms_item_panel > span > a').text)
	
	price = pr.search('tr:nth-child(2) > td.prices_container > div > span.standart > span > ins.num').text.gsub(/ /, '')
	price1 = pr.search('tr:nth-child(2) > td.prices_container > div > span.special > span  > ins.num').text.gsub(/ /, '')
	q1 = pr.search('tr:nth-child(1) > td.product_name.cms_item_panel > div.in_stock_horizontal_position > span:nth-child(1) > span').text.gsub(/много/, '20').gsub(/^$/,'0')
	q2 = pr.search('tr:nth-child(1) > td.product_name.cms_item_panel > div.in_stock_horizontal_position > span:nth-child(2) > span').text.gsub(/много/, '20').gsub(/^$/,'0')
	q3 = pr.search('tr:nth-child(1) > td.product_name.cms_item_panel > div.in_stock_horizontal_position > span:nth-child(3) > span').text.gsub(/много/, '20').gsub(/^$/,'0')
	q4 = pr.search('tr:nth-child(1) > td.product_name.cms_item_panel > div.in_stock_horizontal_position > span:nth-child(4) > span').text.gsub(/много/, '20').gsub(/^$/,'0')
	q5 = pr.search('tr:nth-child(1) > td.product_name.cms_item_panel > div.in_stock_horizontal_position > span:nth-child(6) > span').text.gsub(/много/, '20').gsub(/^$/,'0')
	
	
	@citilinks.each do |c|
	c.update_attributes( :price => price, :price1 => price1, :q1 => q1, :q2 => q2, :q3 => q3, :q4 => q4, :q5 => q5)
	end
	end
	
	@citilink = Citilink.order("id")
	@citilink.each do |c|
	url = "http://www.cbr.ru/scripts/XML_daily.asp"
	data = Nokogiri::XML(open(url))
	a = data.xpath("ValCurs/Valute[@ID = 'R01235']/Value").text
	kurs = a.gsub(/,/, '.')
	c.priceusd = c.price1 / "#{kurs}".to_f if c.price !=nil
	c.save
	c.quantity = c.q1.to_i + c.q2.to_i + c.q3.to_i + c.q4.to_i + c.q5.to_i
	c.save
	end

end


end
