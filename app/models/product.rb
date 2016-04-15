class Product < ActiveRecord::Base
  validates :inid, uniqueness: true
    
  belongs_to :homyproduct
  belongs_to :emag
  belongs_to :rrc
  belongs_to :angel
  belongs_to :energy
  belongs_to :vimcom
  belongs_to :ipmatika
  belongs_to :sskom
  belongs_to :treolan
  belongs_to :citilink
  belongs_to :store
  
  has_many :line_items
  has_many :iorders, :through => :line_items
  has_many :invoice_items
  has_many :invoices, :through => :invoice_items
  has_many :invoice_list_items
  has_many :invoice_list, :through => :invoice_list_items
  has_many :purchase_invoice_items
  has_many :purchase_invoices, :through => :purchase_invoice_items
  has_many :purchase_list_items
  has_many :purchase_list, :through => :purchase_list_items
  has_many :store_items
  has_many :losses, :through => :store_items
  has_many :enters, :through => :store_items
  
  has_many :stocks
  
  require 'open-uri'
  require 'nokogiri'
  require 'rest-client'
  
  def self.find_all_by_inid    
    @products = Product.where("inid = #{:inid}")
  end
  
  def self.to_csv(options = {})
    CSV.generate(options) do |csv|
      csv << column_names
      all.each do |product|
        csv << product.attributes.values_at(*column_names)
      end
    end
  end
      
  def self.downloadproduct #загружаем товары из магазина (всего 1000 товаров по тарифу и они загружаются 4 частями)
     #Product.destroy_all
     myprpage = 0
     while myprpage < 4
       myprpage = myprpage + 1
     
     url = "http://worksys.myinsales.ru/admin/products.xml?&limit=250=&page=#{(myprpage)}"
     
     data = Nokogiri::XML(open(url, :http_basic_authentication => ['a2e2ed5ba6560944845dbf38f2223298' ,'0e734e3c93ca9795f87313c83c5ebbcf']))
     product = "products/product"
     mypr = data.xpath(product)
     
     mypr.each do |pr|
		@product = Product.new
		@product.category_id = pr.xpath("category-id").text
		@product.inid = pr.xpath("id").text
		@product.sku = pr.xpath("variants/variant/sku").text
		@product.title = pr.xpath("title").text
		@product.short_description = pr.xpath("short-description").text
		@product.quantity = pr.xpath("variants/variant/quantity").text
		@product.cost_price = pr.xpath("variants/variant/cost-price").text
		@product.price = pr.xpath("variants/variant/price").text
		@product.variant_id = pr.xpath("variants/variant/id").text	
		@product.save

     end
     end 
  end
  
  def self.updateproduct
  
  myprpage = 0
     while myprpage < 4
       myprpage = myprpage + 1
     
     url = "http://worksys.myinsales.ru/admin/products.xml?&limit=250=&page=#{(myprpage)}"
     
     data = Nokogiri::XML(open(url, :http_basic_authentication => ['a2e2ed5ba6560944845dbf38f2223298' ,'0e734e3c93ca9795f87313c83c5ebbcf']))
     product = "products/product"
     mypr = data.xpath(product)
     
     mypr.each do |pr|
		
		category_id = pr.xpath("category-id").text
		inid = pr.xpath("id").text
		sku = pr.xpath("variants/variant/sku").text
		title = pr.xpath("title").text
		short_description = pr.xpath("short-description").text
		quantity = pr.xpath("variants/variant/quantity").text
		cost_price = pr.xpath("variants/variant/cost-price").text
		price = pr.xpath("variants/variant/price").text
		variant_id = pr.xpath("variants/variant/id").text
		
		@products = Product.where("inid = ?", pr.xpath("id").text)
		@products.each do |p|
         p.update_attributes(:category_id => category_id, :inid => inid, :sku => sku, :title => title, :short_description => short_description, :quantity => quantity, :cost_price => cost_price, :price => price, :variant_id => variant_id )
		end		

     end
     end 
  
  end
  
  
  def self.checkquantity
  
  @products = Product.order("id")
    @products.each do |product|   
      a = product.homyproduct.quantity_all_free if product.homyproduct != nil #unless product.homyproduct.nil? - обе записи это если ... не пусто
      b = product.emag.quantity unless product.emag.nil?
      c = product.rrc.quantity unless product.rrc.nil?
      d = product.angel.quantity unless product.angel.nil?
      #e = product.energy.quantity if product.energy !=nil -------- + "#{e}".to_i
      f = product.vimcom.quantity_free if product.vimcom !=nil
      g = product.ipmatika.quantity_free if product.ipmatika !=nil
      h = product.sskom.quantity if product.sskom !=nil
      i = product.treolan.quantity if product.treolan !=nil
      k = product.citilink.quantity if product.citilink !=nil
      l = product.store.quantity if product.store !=nil
      
      sum = "#{a}".to_i + "#{b}".to_i + "#{c}".to_i + "#{d}".to_i + "#{f}".to_i + "#{g}".to_i + "#{h}".to_i + "#{i}".to_i + "#{k}".to_i + "#{l}".to_i

product.update_attributes(:quantity => sum)
    end
    # @products = Product.where(:quantity => "0") # это временная заглушка для того чтобы у товаров не было нуля, так как при нуле товары не показываются в рекламе
    # @products.each do |a|  # @products.each { |a| a.update_attributes(:quantity => "1") }
      # a.update_attributes(:quantity => "1")
    # end
  end
    
  def self.synchronize # алгоритм синхронизации рабочий, но с инсалес выдаёт ошибку при массовом обновлении (единичное обновление из обновления товара работает на "ура". Поэтому для обновления остатков использую экспорт в csv и загрузку через импорт в инсалесе - занимает 5 минут)
  
	   
      @products = Product.order("id").limit(250)
      @products.each do |pr|
       
       uri = "http://a2e2ed5ba6560944845dbf38f2223298:0e734e3c93ca9795f87313c83c5ebbcf@worksys.myinsales.ru/admin/products/#{(pr.inid)}/variants/#{(pr.variant_id)}.xml"
 
      response = RestClient.put uri, "<variant><quantity>#{(pr.quantity)}</quantity></variant>", :accept => :xml, :content_type => "application/xml"
      end
      
      sleep 240
      
      @products = Product.order("id").limit(250).offset(250)
      @products.each do |pr|
        
        uri = "http://a2e2ed5ba6560944845dbf38f2223298:0e734e3c93ca9795f87313c83c5ebbcf@worksys.myinsales.ru/admin/products/#{(pr.inid)}/variants/#{(pr.variant_id)}.xml"
        response = RestClient::Request.execute(:method => :put, :url => "#{(uri)}", :payload => "<variant><quantity>#{(pr.quantity)}</quantity></variant>", :headers => {:accept => :xml, :content_type => "application/xml"})
      end
      
      sleep 240
    
     @products = Product.order("id").limit(250).offset(500)
     @products.each do |pr|
       
       uri = "http://a2e2ed5ba6560944845dbf38f2223298:0e734e3c93ca9795f87313c83c5ebbcf@worksys.myinsales.ru/admin/products/#{(pr.inid)}/variants/#{(pr.variant_id)}.xml"
        response = RestClient::Request.execute(:method => :put, :url => "#{(uri)}", :payload => "<variant><quantity>#{(pr.quantity)}</quantity></variant>", :headers => {:accept => :xml, :content_type => "application/xml"})
     end
     
     sleep 240
    
    @products = Product.order("id").limit(250).offset(750)
    @products.each do |pr|
      
     uri = "http://a2e2ed5ba6560944845dbf38f2223298:0e734e3c93ca9795f87313c83c5ebbcf@worksys.myinsales.ru/admin/products/#{(pr.inid)}/variants/#{(pr.variant_id)}.xml"
        response = RestClient::Request.execute(:method => :put, :url => "#{(uri)}", :payload => "<variant><quantity>#{(pr.quantity)}</quantity></variant>", :headers => {:accept => :xml, :content_type => "application/xml"})
    end
   
    
  end
  
  
end
