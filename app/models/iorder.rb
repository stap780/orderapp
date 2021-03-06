class Iorder < ActiveRecord::Base
	belongs_to :status
	belongs_to :mycourier
	belongs_to :iml
	belongs_to :dpd
	belongs_to :post
	belongs_to :courier
	belongs_to :client
	has_one    :invoice
	
	has_many :line_items
	has_many :products, :through => :line_items
	accepts_nested_attributes_for :line_items, reject_if: proc { |attributes| attributes['title'].blank? }, allow_destroy: true 
	accepts_nested_attributes_for :products
	validates :number, uniqueness: true 
	#delegate :title, to: :product, prefix: true
	
	delegate :name ,:name=, to: :client, prefix: true, allow_nil: true

  
  require 'open-uri'
  require 'nokogiri'
  require 'rest-client'
  require 'json'
  
  def self.find_all_by_number
      @iorders = Iorder.where("number = #{:number}")
  end
  
    
  def self.downloadorder
  
     uri = "http://a2e2ed5ba6560944845dbf38f2223298:0e734e3c93ca9795f87313c83c5ebbcf@worksys.myinsales.ru/admin/orders.xml"
     response = RestClient.get uri, :accept => :xml, :content_type => "application/xml"
     data = Nokogiri::XML(response)
	order = "orders/order" #определение категории в файле в переменную
	myio = data.xpath(order) # определение пути в переменную
	myio.each do |io| #начало процесса создания или обновления заказов
		inid = io.xpath("id").text
		number = io.xpath("number").text
		instatus = io.xpath("fulfillment-status").text
		a = Status.find_by_instatus(instatus)
		status = a.id
		financial = io.xpath("financial-status").text
		payment = io.xpath("payment-title").text
		delivery = io.xpath("delivery-title").text
		client = io.xpath("client/name").text
		client_middlename = io.xpath("client/middlename").text
		client_surname = io.xpath("client/surname").text
		phone = io.xpath("client/phone").text
		email = io.xpath("client/email").text
		total = io.xpath("total-price").text
		shipping_zip = io.xpath("shipping-address/zip").text
		shipping_city = io.xpath("shipping-address/city").text
		shipping_address = io.xpath("shipping-address/address").text	
		deliveryprice = io.xpath("full-delivery-price").text
		discount_percent = io.xpath("discount/percent").text
		
		
		@iorder = Iorder.find_by_inid(inid)
			if @iorder.present?
				@iorder.update_attributes(:status_id => status, :financial => financial, :payment => payment, :delivery => delivery, :total => total, :deliveryprice => deliveryprice, :discount_percent => discount_percent) #:clientname => client, :client_middlename => client_middlename, :client_surname => client_surname, :phone => phone, :email => email, :shipping_zip => shipping_zip, :shipping_city => shipping_city, :shipping_address => shipping_address)
				else
				# далее создаём заказ и клиента
				@iorder = Iorder.new(:inid => inid, :number => number, :status_id => status, :financial => financial, :payment => payment, :delivery => delivery, :total => total, :deliveryprice => deliveryprice, :discount_percent => discount_percent)
				@iorder.save
			
				@client = Client.find_by_phone(phone)
					if @client.present?
						@iorder.client_id = @client.id
						@iorder.save
						else
						@client = Client.new(name: client, middlename: client_middlename, surname: client_surname, phone: phone, email: email, zip: shipping_zip, city: shipping_city, address: shipping_address)
						@client.save
						@iorder.client_id = @client.id
						@iorder.save
					end
			end
		end #конец процесса создания или обновления заказов
	
	@iorders = Iorder.order("number desc").limit(10) #записываем данные по позициям в заказе
   	@iorders.each do |iorder|
   	r = RestClient.get ("http://a2e2ed5ba6560944845dbf38f2223298:0e734e3c93ca9795f87313c83c5ebbcf@worksys.myinsales.ru/admin/orders/#{(iorder.inid)}.json")
   	h = JSON.parse(r)
   	h["order_lines"]
	   	h["order_lines"].each do |key, value|
	   	variantid = key["variant_id"]
	  	#product = Product.find_by_variant_id("#{variantid}")
	  	productinid = key["product_id"]
	  	product = Product.find_by_inid("#{productinid}")
	  	quantity = key["quantity"]
	 	price = key["sale_price"]
	 	sum = quantity * price
	 	
	 	li = iorder.line_items.find_by_product_id("#{product["id"]}") 
	 	if li.present?
	 	li.update_attributes("quantity"=> quantity , "price" => price, "sum" => sum)
	 	else 
	 	iorder.line_items.create("title" => product["title"], "quantity"=> quantity, "product_id" => product["id"] , "price" => price, "sum" => sum)
	 	end
	  	end
  	iorder.total_price = iorder.line_items.sum(:sum) - iorder.line_items.sum(:sum) * iorder.discount_percent.to_i/100 + iorder.deliveryprice.to_i
  	iorder.save
    end  
		
  end
  
  
  def self.updateorder
  end
  
  def self.checkdelivery 
  
    @iorders = Iorder.order("number desc").limit(50)
    @iorders.each do |io|
    i = io.iml.statusnum if io.iml != nil
    if i == 1
	io.status = Status.find_by_number("7")
	io.save
	uri = "http://a2e2ed5ba6560944845dbf38f2223298:0e734e3c93ca9795f87313c83c5ebbcf@worksys.myinsales.ru/admin/orders/#{(io.inid)}.xml"
  
    response = RestClient.put uri, "<order><fulfillment-status>#{(io.status.instatus)}</fulfillment-status></order>", :accept => :xml, :content_type => "application/xml"
	else
	if i == 3
	io.status = Status.find_by_number("9")
	io.save
	uri = "http://a2e2ed5ba6560944845dbf38f2223298:0e734e3c93ca9795f87313c83c5ebbcf@worksys.myinsales.ru/admin/orders/#{(io.inid)}.xml"
  
    response = RestClient.put uri, "<order><fulfillment-status>#{(io.status.instatus)}</fulfillment-status></order>", :accept => :xml, :content_type => "application/xml"
    end
    end
    
    d = io.dpd.state if io.dpd != nil
    if d == "Delivered"
	io.status = Status.find_by_number("7")
	io.save
	uri = "http://a2e2ed5ba6560944845dbf38f2223298:0e734e3c93ca9795f87313c83c5ebbcf@worksys.myinsales.ru/admin/orders/#{(io.inid)}.xml"
  
    response = RestClient.put uri, "<order><fulfillment-status>#{(io.status.instatus)}</fulfillment-status></order>", :accept => :xml, :content_type => "application/xml"
	else
	if d == "ReturnedFromDelivery"
	io.status = Status.find_by_number("9")
	io.save
	uri = "http://a2e2ed5ba6560944845dbf38f2223298:0e734e3c93ca9795f87313c83c5ebbcf@worksys.myinsales.ru/admin/orders/#{(io.inid)}.xml"
  
    response = RestClient.put uri, "<order><fulfillment-status>#{(io.status.instatus)}</fulfillment-status></order>", :accept => :xml, :content_type => "application/xml"
    end
    end
	

    end       

  end
	
	
end
