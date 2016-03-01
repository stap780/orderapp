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
	accepts_nested_attributes_for :line_items, reject_if: proc { |attributes| attributes['title'].blank? }, allow_destroy: true #, reject_if: proc { |attributes| attributes['product_id'].blank? }
	accepts_nested_attributes_for :products
	validates :number, uniqueness: true 
	#delegate :title, to: :product, prefix: true

  
  require 'open-uri'
  require 'nokogiri'
  require 'rest-client'
  require 'json'
  
  def self.find_all_by_number
      @iorders = Iorder.where("number = #{:number}")
  end
    
  def self.downloadorder 
     #Iorder.destroy_all #удаляет все из базы данных   "http://a2e2ed5ba6560944845dbf38f2223298:0e734e3c93ca9795f87313c83c5ebbcf@worksys.myinsales.ru/admin/orders.xml"
     url = "http://worksys.myinsales.ru/admin/orders.xml"
     data = Nokogiri::XML(open(url, :http_basic_authentication => ['a2e2ed5ba6560944845dbf38f2223298' ,'0e734e3c93ca9795f87313c83c5ebbcf']))
     
     order = "orders/order" #определение категории в файле в переменную
     
     myio = data.xpath(order) # определение пути в переменную
     
     myio.each do |io| # создание хэша из данных заказа и запись их в переменные по каждому заказу
    @iorder = Iorder.new
    @iorder.inid = io.xpath("id").text
    @iorder.number = io.xpath("number").text
    s = Status.find_by_number("1")
    #@iorder.status = io.xpath("fulfillment-status").text
    @iorder.status = s
    @iorder.financial = io.xpath("financial-status").text
    @iorder.payment = io.xpath("payment-title").text
    @iorder.delivery = io.xpath("delivery-title").text 
    @iorder.clientname = io.xpath("client/name").text
    @iorder.client_middlename = io.xpath("client/middlename").text 
    @iorder.client_surname = io.xpath("client/surname").text 
    @iorder.phone = io.xpath("client/phone").text
    @iorder.email = io.xpath("client/email").text
    @iorder.total = io.xpath("total-price").text
    @iorder.shipping_zip = io.xpath("shipping-address/zip").text 
    @iorder.shipping_city = io.xpath("shipping-address/city").text 
    @iorder.shipping_address = io.xpath("shipping-address/address").text 
    @iorder.discount_percent = io.xpath("discount/percent").text
    @iorder.deliveryprice = io.xpath("full-delivery-price").text
    @iorder.save
    
    client = Client.find_by_phone(io.xpath("client/phone").text)
    if client.present?
        @iorder.client_id = client.id
		@iorder.save
    else
    	@client = @iorder.create_client(name: @iorder.clientname, middlename: @iorder.client_middlename, surname: @iorder.client_surname, phone: @iorder.phone, email: @iorder.email, zip: @iorder.shipping_zip, city: @iorder.shipping_city, address: @iorder.shipping_address)
		@iorder.client_id = @client.id
		@iorder.save
    end
	end
    
  end
  
  def self.updateorder
    mytime = Time.now - 12.hour
    url = URI.encode("http://worksys.myinsales.ru/admin/orders.xml?updated_since=#{(mytime)}")
    data = Nokogiri::XML(open(url, :http_basic_authentication => ['a2e2ed5ba6560944845dbf38f2223298' ,'0e734e3c93ca9795f87313c83c5ebbcf']))
    iorder = "orders/order"
    @iorders = data.xpath(iorder)
    @iorders.each do |io| 
      
    @iorders = Iorder.where("inid = ?", io.xpath("id").text)
    
    inid = io.xpath("id").text
    status = io.xpath("fulfillment-status").text
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
	
      @iorders.each do |io|
      
        io.update_attributes(:instatus => status, :financial => financial, :payment => payment, :delivery => delivery, :clientname => client, :client_middlename => client_middlename, :client_surname => client_surname, :phone => phone, :email => email, :total => total, :shipping_zip => shipping_zip, :shipping_city => shipping_city, :shipping_address => shipping_address, :deliveryprice => deliveryprice, :discount_percent => discount_percent) 
        
        if io.instatus == "new"
        io.status = Status.find_by_number("1")
        else
        if io.instatus == "accepted"
        io.status = Status.find_by_number("2")
        else
        if io.instatus == "approved"
        io.status = Status.find_by_number("3")
        else
        if io.instatus == "dispatched"
        io.status = Status.find_by_number("5")
        else
        if io.instatus == "delivered"
        io.status = Status.find_by_number("7")
        else
        if io.instatus == "declined"
        io.status = Status.find_by_number("8")
        else
        if io.instatus == "returned"
        io.status = Status.find_by_number("9")
        end
        end
        end
        end
        end
		end
		end
        io.save
        
      end      
    end
	
	@iorders = Iorder.order("number desc").limit(25)
   	@iorders.each do |iorder|
   	r = RestClient.get ("http://a2e2ed5ba6560944845dbf38f2223298:0e734e3c93ca9795f87313c83c5ebbcf@worksys.myinsales.ru/admin/orders/#{(iorder.inid)}.json")
   	h = JSON.parse(r)
   	h["order_lines"]
	   	h["order_lines"].each do |key, value|
	   	variantid = key["variant_id"]
	  	product = Product.find_by_variant_id("#{variantid}")
	  	quantity = key["quantity"]
	 	price = key["sale_price"]
	 	sum = quantity * price
	 	
	 	li = iorder.line_items.find_by_product_id("#{product["id"]}")
	 	if li.present?
	 	li.quantity = quantity
	 	li.price = price
	 	li.sum = sum
	 	li.save
	 	else 
	 	iorder.line_items.create("title" => product["title"], "quantity"=> quantity, "product_id" => product["id"] , "price" => price, "sum" => sum)
	 	end
	  	end
  	iorder.total_price = iorder.line_items.sum(:sum) - iorder.line_items.sum(:sum) * iorder.discount_percent.to_i/100 + iorder.deliveryprice.to_i
  	iorder.save
    end  
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
	

	 # a = io.iml.status if io.iml != nil
#  	b = io.iml.state if io.iml != nil
#  	dname = io.mycourier.title if io.mycourier != nil
#  	uri = "http://a2e2ed5ba6560944845dbf38f2223298:0e734e3c93ca9795f87313c83c5ebbcf@worksys.myinsales.ru/admin/application_widgets/13399.xml"
#    
#      response = RestClient.put uri, "<application-widget><code>&lt;html xmlns=&quot;http://www.w3.org/1999/xhtml&quot;&gt;<br/>&lt;body&gt;<br/>&lt;p&gt;&#x0421;&#x043b;&#x0443;&#x0436;&#x0431;&#x0430; &#x0434;&#x043e;&#x0441;&#x0442;&#x0430;&#x0432;&#x043a;&#x0438;: #{(dname)}<br/>&lt;p id='status'&gt;&#x0421;&#x0442;&#x0430;&#x0442;&#x0443;&#x0441; &#x0434;&#x043e;&#x0441;&#x0442;&#x0430;&#x0432;&#x043a;&#x0438;: #{(a)} - #{(b)}&lt;/p&gt;<br/>&lt;/body&gt;<br/>&lt;/html&gt;<br/></code></application-widget>", :accept => :xml, :content_type => "application/xml"
    end       

  end
	
	
end
