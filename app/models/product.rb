class Product < ActiveRecord::Base
  validates :inid, uniqueness: true
    
  belongs_to :homyproduct
  belongs_to :emag
  belongs_to :rrc
  belongs_to :angel
  #belongs_to :energy
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
  has_many :variants, :dependent => :destroy
  accepts_nested_attributes_for :variants, allow_destroy: true #,reject_if: proc { |attributes| attributes['weight'].blank? }

  has_many :stocks
  
  require 'open-uri'
  require 'nokogiri'
  require 'rest-client'
  
	def self.ransackable_attributes(auth_object = nil)
      super & ['id', 'title', 'sku', 'quantity', 'cost_price']#,'emag_id', 'rrc_id', 'homyproduct_id', 'ipmatika_id', 'angel_id', 'vimcom_id', 'citilink_id']
	end
  
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
  
  def self.skidka(skidka)
  @products = Product.order("id")
  @products.each do |p|
    if p.price.to_f > 60
    p.sell_price = (p.price.to_f - p.price.to_f*skidka.to_f/100).round(2)
    p.save
    else
    p.sell_price = p.price
    p.save
    end
    end
  end
  
      
  def self.downloadproduct #загружаем или обновляем товары из магазина (всего 1000 товаров по тарифу и они загружаются 4 частями)
     #Product.destroy_all
     myprpage = 0
     while myprpage < 4
       myprpage = myprpage + 1
          
     uri = "http://a2e2ed5ba6560944845dbf38f2223298:0e734e3c93ca9795f87313c83c5ebbcf@worksys.myinsales.ru/admin/products.xml?&limit=250=&page=#{(myprpage)}"
     response = RestClient.get uri, :accept => :xml, :content_type => "application/xml"
     data = Nokogiri::XML(response)
     product = "products/product"
     mypr = data.xpath(product)
     
		mypr.each do |pr|
			category_id = pr.xpath("category-id").text
			inid = pr.xpath("id").text
			sku = pr.xpath("variants/variant/sku").first.text
			title = pr.xpath("title").text
			short_description = pr.xpath("short-description").text
			
			@product = Product.where("inid = ?", pr.xpath("id").text)
			if @product.present?
			@product.each do |p|
			p.update_attributes(:category_id => category_id, :short_description => short_description) #, :title => title, :inid => inid, :sku => sku
			end
			else
			@product.create(:category_id => category_id, :inid => inid, :sku => sku, :title => title, :short_description => short_description)
			end
		end
		
	end
	 end
  
 
  
  def self.updateproduct
	#загружаем и обновляем варианты по каждому товару из магазина 
	@products = Product.order(:id)#.offset(360)
	@products.each do |product|
		variant = Variant.find_by_product_id(product.id)
		if variant.nil?#!variant.nil?
		uri = "http://a2e2ed5ba6560944845dbf38f2223298:0e734e3c93ca9795f87313c83c5ebbcf@worksys.myinsales.ru/admin/products/#{product.inid}.xml"
		begin
		response = RestClient.get uri, :accept => :xml, :content_type => "application/xml"
		
 		if response.code == 200
		data = Nokogiri::XML(response)
		mypr = data.xpath("//variants/variant")
		
			mypr.each do |var|
				variant_inid = var.xpath("id").text
				option_id = var.xpath("option-values/option-value/id").text
					if option_id.present?
					a = ProductOption.find_by_opt_value_inid(option_id)
					product_option_id = a.id 
					end
				sku = var.xpath("sku").text
				cost_price = var.xpath("cost-price").text
				price = var.xpath("price").text
				old_price = var.xpath("old-price").text
				quantity = var.xpath("quantity").text
				weight = var.xpath("weight").text
				
				@variant = Variant.find_by_variant_inid("#{(variant_inid)}")
					if @variant.present?
					@variant.update_attributes( :sku => sku, :cost_price => cost_price, :price => price, :old_price => old_price, :quantity => quantity, :weight => weight, :product_option_id => product_option_id)
					else
					@variant = Variant.new(:product_id => product.id, :variant_inid => variant_inid,:product_option_id => product_option_id, :sku => sku, :cost_price => cost_price, :price => price, :old_price => old_price, :quantity => 0, :weight => weight)
					@variant.save
					end
			end
			#sleep(0.2) # на 0.4 секунды (sleep(4.minutes) или sleep(2.hours))	
		end
 		
 		rescue => e
			if e.response.code == 404
			product.delete
 			end
 			if e.response.code == 503
	 			puts "sleep now"
	 		sleep(1.minutes)
	 		end	
 		end
	end
	end
  end
  
  
  def self.checkquantity
  	# #Старый вариант
# 	@products = Product.order("id")
# 	@products.each do |product|   
# 	a = product.homyproduct.quantity_all_free if product.homyproduct != nil #unless product.homyproduct.nil? - обе записи это если ... не пусто
# 	b = product.emag.quantity unless product.emag.nil?
# 	c = product.rrc.quantity unless product.rrc.nil?
# 	d = product.angel.quantity unless product.angel.nil?
# 	#e = product.energy.quantity if product.energy !=nil -------- + "#{e}".to_i
# 	f = product.vimcom.quantity_free if product.vimcom !=nil
# 	g = product.ipmatika.quantity_free if product.ipmatika !=nil
# 	#h = product.sskom.quantity if product.sskom !=nil
# 	#i = product.treolan.quantity if product.treolan !=nil
# 	#k = product.citilink.quantity if product.citilink !=nil
# 	l = product.store.quantity if product.store !=nil
# 	
# 	sum = "#{a}".to_i + "#{b}".to_i + "#{c}".to_i + "#{d}".to_i + "#{f}".to_i + "#{g}".to_i + "#{l}".to_i
# 	
# 	product.update_attributes(:quantity => sum)
# 	#дополнение, чтобы обновить остатки в вариантах для правильной временной загрузки в магазин из раздела Товары
# 	if product.variants !=nil 
# 	product.variants.first.quantity = product.quantity 
# 	product.variants.first.save
# 	end
# 	end
	
	# Новый вариант
	# Обновляем товары Айпиматика
	ip_variant = Variant.where('product_option_id = ?', 2) #находим варианты продуктов относящийся к поставшику айпиматика
	ip_variant.each do |ipv|
		puts "#{(ipv.product_id)}"
	ip_product = Ipmatika.find_by_id(ipv.supplier_id) #обновляем кол-во по данному товару поставщика
		if !ip_product.nil?
		if !ip_product.quantity_free.nil?
		ipv.quantity = ip_product.quantity_free
		else
		ipv.quantity = 0
		end 
		ipv.cost_price = ip_product.cost_price
		ipv.save
		if !ipv.cost_price.nil?
		#ipv.price = ipv.cost_price + ipv.cost_price*10/100
		ipv.price = (ipv.cost_price.to_f + ip_product.price.to_f)/2
		else
		ipv.price = 0
		end
		ipv.old_price = ip_product.price
		ipv.save
		end
	end
	
       # Обновляем товары Премьер
	homy_variant = Variant.where('product_option_id = ?', 3) #находим варианты продуктов относящийся к поставшику Премьер
	homy_variant.each do |hv|
		puts "#{(hv.sku)}"
	homy_product = Homyproduct.find_by_id(hv.supplier_id) #обновляем кол-во по данному товару поставщика
	hv.quantity = homy_product.quantity_all_free
	hv.cost_price = homy_product.price
	hv.save
	hv.price = (hv.cost_price.to_f + homy_product.sell_price.to_f)/2
	hv.old_price = homy_product.sell_price
	hv.save
	end
	
	# Обновляем товары Имаг
	emag_variant = Variant.where('product_option_id = ?', 4) #находим варианты продуктов относящийся к поставшику Имаг
	emag_variant.each do |ev|
 		puts "#{(ev.sku)}"
	emag_product = Emag.find_by_id(ev.supplier_id) #обновляем кол-во по данному товару поставщика
	ev.quantity = emag_product.quantity
	ev.cost_price = emag_product.cost_price
	ev.save
	if !ev.cost_price.nil?
	ev.price = (ev.cost_price.to_f + emag_product.price.to_f)/2
	else
	ev.price = 0
	end
	ev.old_price = emag_product.price
	ev.save
	end
	
	# Обновляем товары Gstele
	gstele_variant = Variant.where('product_option_id = ?', 5) #находим варианты продуктов относящийся к поставшику Gstele
	gstele_variant.each do |gv|
	gstele_product = Gstele.find_by_id(gv.supplier_id) #обновляем кол-во по данному товару поставщика
	gv.quantity = gstele_product.quantity
	gv.cost_price = gstele_product.cost_price.to_f.round(2)
	gv.save
	if !gv.cost_price.nil?
# 	gv.price = (gv.cost_price * 1.09).to_f.round(2)
	gv.price = (gv.cost_price.to_f + gstele_product.price.to_f)/2
	else
	gv.price = 0
	end
	gv.old_price = gstele_product.price.to_f.round(2)
	gv.save
	end
	
	# Обновляем товары РРС
	rrc_variant = Variant.where('product_option_id = ?', 6) #находим варианты продуктов относящийся к поставшику РРС
	rrc_variant.each do |rrcv|
		puts "#{(rrcv.sku)}"
	rrc_product = Rrc.find_by_id(rrcv.supplier_id) #обновляем кол-во по данному товару поставщика
	rrcv.quantity = rrc_product.quantity
	rrcv.cost_price = rrc_product.cost_price
	rrcv.save
	if !rrcv.cost_price.nil?
	rrcv.price = (rrcv.cost_price.to_f + rrc_product.price.to_f )/2
	else
	rrcv.price = 0
	end
	rrcv.old_price = rrc_product.price
	rrcv.save
	end
	
	# Обновляем товары Цифровой Ангел
	angel_variant = Variant.where('product_option_id = ?', 7) #находим варианты продуктов относящийся к поставшику 
	angel_variant.each do |av|
	angel_product = Angel.find_by_id(av.supplier_id) #обновляем кол-во по данному товару поставщика
	av.quantity = angel_product.quantity
	av.cost_price = angel_product.cost_price
	av.save
	av.price = (av.cost_price.to_f + angel_product.price.to_f)/2
	av.old_price = angel_product.price
	av.save
	end
	
	# Обновляем товары Вимком
	vimcom_variant = Variant.where('product_option_id = ?', 8) #находим варианты продуктов относящийся к поставшику 
	vimcom_variant.each do |vv|
	vimcom_product = Vimcom.find_by_id(vv.supplier_id) #обновляем кол-во по данному товару поставщика
	vv.quantity = vimcom_product.quantity_free
	vv.cost_price = vimcom_product.cost_price
	vv.save
	vv.price = (vv.cost_price.to_f + vimcom_product.price.to_f)/2
	vv.old_price = vimcom_product.price
	vv.save
	end
	
	# считаем сумму по остаткам вариантов товара и записываем значение в вариант товара - Розница, а так же обновляем цены
	product = Product.order(:id)
	product.each do |product|
		puts "#{(product.sku)}"
	if product.variants.count >= 2
	v = Variant.find_by_id(product.variants.where('product_option_id = ?', 1).first.id) 
	v.quantity = product.variants.sum(:quantity) - product.variants.where('product_option_id = ?', 1).first.quantity
	a = ((product.variants.sum(:cost_price)).to_f - (product.variants.where('product_option_id = ?', 1).first.cost_price).to_f).to_f.round(2)
	b = product.variants.count - 1
		if b > 0
		v.cost_price = (a / b).to_f.round(2)
		v.save
		else
		b = 1
		v.cost_price = (a / b).to_f.round(2)
		v.save
		end
	if v.old_price.nil?
	v.old_price = 0 # Это заглушка чтобы посчитать РРЦ, так как в варианте Розница она равна старой у вариантов Поставщиков  
	v.save
	c = ((product.variants.sum(:old_price)).to_f - (product.variants.where('product_option_id = ?', 1).first.old_price).to_f).to_f.round(2)
	d = product.variants.count - 1
		if d > 0
		v.price = (c / d).to_f.round(2)
		v.save
		else
		d = 1
		v.price = (c / d).to_f.round(2)
		v.save
		end
	end
	v.old_price = nil #цена РРЦ
	v.save

	#Обновляем данные в продукте - пока временно, так как можно сделать вывод данных в таблице product index и данных варианта розница
	product.quantity = v.quantity
# 	puts "#{(product.sku)}"
	product.cost_price = v.cost_price
	product.sell_price = v.price #Цена РРЦ
	product.price = v.old_price
	product.save
	end
	end
	
	#корректируем цены Розница по Yealink
	variant_yealink = Variant.where('sku Like ? and product_option_id = ?', '%yl%', 1)
	variant_yealink.each do |v|
		puts "#{(v.sku)}"
		cost_price = Variant.where('product_option_id = ? and product_id = ?', 2, v.product_id).first.cost_price.to_f.round(2)
		price = Variant.where('product_option_id = ? and product_id = ?', 2, v.product_id).first.old_price.to_f.round(2)
		old_price = nil
		v.update_attributes(:cost_price => cost_price, :price => price, :old_price =>old_price)
	end
  end
    

  
end
