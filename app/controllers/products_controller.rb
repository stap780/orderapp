# -*- encoding : utf-8 -*-
class ProductsController < ApplicationController
 
  require 'open-uri'
  require 'nokogiri'
  require 'rest-client'

  before_action :set_product, only: [:show, :edit, :update, :destroy]
  before_action :authorize,  except: [:advt]
	
  def authorize
    if current_user.nil?
      redirect_to login_url, alert: "Not authorized! Please log in."
     end
  end
  
  

  # GET /products
  def index
    
    @search = Product.ransack(params[:q]) #используется gem ransack для поиска и сортировки
    @search.sorts = 'title asc' if @search.sorts.empty? # сортировка таблицы по алфавиту по умолчанию 
    
    @products = @search.result.paginate(page: params[:page], per_page: 50)
    #@search.build_condition if @search.conditions.empty?
    @totalproducts = Product.count
    b = Product.where(:sku => '').count
    @totalproductssku = @totalproducts.to_i - "#{b}".to_i
    #@totalproductssku = Product.where("cast(sku as text) IS NOT ?", nil).count
    @zeroquantity = Product.where("cast(quantity as integer) = ?", 0).count
    @qnotzero = Product.where("cast(quantity as integer) > ?", 0).count
    @products_all = Product.all
    
    Rails.cache.write("q",params[:q]) #записывает данные запроса в кэш чтобы потом прочитать (вызвать) их в том месте где надо на странице (например в скидке или мультиредактировании)
    
    respond_to do |format|
      format.html
      format.csv { send_data @products_all.to_csv }
      format.xls # { send_data @products_all.to_csv(col_sep: "\t") }
      format.xml
    end      
  end
  
  def advt
	@advt_products = Product.where("quantity > 0")
	url = "http://www.cbr.ru/scripts/XML_daily.asp"
	data = Nokogiri::XML(open(url))
	a = data.xpath("ValCurs/Valute[@ID = 'R01235']/Value").text
	@kurs = a.gsub(/,/, '.').to_f
	  
	#@products = Product.where("quantity > ?", 0)  
	@products = Product.where('sku Like ? ', '%yl%')
	advt_csv_string = CSV.generate(:col_sep => ';') do |csv|
         csv << ['title','descr1', 'descr2', 'url', 'keyword/#thematic#','price', 'stopwords']#,'autobid'
         @products.each do |product|
	        title = product.title 
	        var = product.variants.where('product_option_id = 2').first
			rub_price = (var.price.to_f * @kurs.to_f).to_f.round(2) #rub_price = (product.sell_price.to_f * @kurs.to_f).to_f.round(2)
			descr1 = 'от ' + rub_price.to_s + ' руб.' 
			descr2 = 'Скидки бизнесу. Доставка по России.' 
			url ='http://www.teletri.ru/product_by_id/' + product.inid.to_s 
			keywords =  product.title, product.title + ' купить' 
			stopwords = 'настройка, ремонт'#, инструкция, описание' 
			price = 10
			autobid = 1
           csv << [title, descr1, descr2, url, keywords, price, stopwords]#, autobid
         end
    end         
  
#    send_data advt_csv_string.encode("cp1251"),
#    :type => 'text/csv;  header=present', #charset=iso-8859-1;
#    :disposition => "attachment; filename=advt.csv"
   respond_to do |format|
      format.csv { send_data advt_csv_string.encode("cp1251"),
                   :type => 'text/csv;  header=present', #charset=iso-8859-1;
                   :disposition => "attachment; filename=advt.csv" }
      format.xml 
    end  
	
   end
   def advthidden
	   @advt_hidden = Product.where("category_id" => 5460573)
	   respond_to do |format|
      format.xml 
    end 
	 end

  # GET /products/1
  def show
  end

  # GET /products/new
  def new
    @product = Product.new
  end

  # GET /products/1/edit
  def edit
  end

  # POST /products
  def create
    @product = Product.new(product_params)

    if @product.save
      redirect_to @product, notice: 'Product was successfully created.'
    else
      render :new
    end
  end

  def downloadproduct 
    @product = Product.downloadproduct
    flash[:notice] = 'Products was successfully downloaded'
    redirect_to products_path
  end
  
  def updateproduct
    @product = Product.updateproduct
    flash[:notice] = 'Products was successfully updated'
    redirect_to products_path
  end
  
  def checkquantity
    @product = Product.checkquantity
    flash[:notice] = 'Products quantity was successfully check'
    redirect_to products_path
  end
  
  def synchronize
    @product = Product.synchronize
    flash[:notice] = 'Products quantity was successfully synchronize'
    redirect_to products_path
  end
  
  def skidka
  params[:q] = Rails.cache.read("q")
  @search = Product.search(params[:q])
  skidka = params[:skidka]
  @products = @search.result.skidka(skidka)
    flash[:notice] = 'Скидка установлена'
    redirect_to products_path
  end
	  
  
  # PATCH/PUT /products/1
  def update
    if @product.update(product_params)
    @product.variants.each do |pv|
    variant = Variant.where(product_id: "#{pv["product_id"]}", product_option_id: "#{pv["product_option_id"]}")
	    if variant.present?
	    pv.update_attributes(sku: "#{pv["sku"]}", quantity: "#{pv["quantity"]}",weight: "#{pv["weight"]}", price: "#{pv["price"]}", cost_price: "#{pv["cost_price"]}", old_price: "#{pv["old_price"]}", supplier_id: "#{pv["supplier_id"]}")
	    else
	    pv.create(sku: "#{pv["sku"]}", quantity: "#{pv["quantity"]}", price: "#{pv["price"]}", cost_price: "#{pv["cost_price"]}", old_price: "#{pv["old_price"]}", supplier_id: "#{pv["supplier_id"]}", product_id: "#{pv["product_id"]}", product_option_id: "#{pv["product_option_id"]}", weight: "#{pv["weight"]}")
	    
	    end
    
    end
      
      redirect_to @product , notice: 'Product was successfully updated'
    else
      render :edit
    end
  end

  # DELETE /products/1
  def destroy
    @product.destroy
    redirect_to products_url, notice: 'Product was successfully destroyed.'
  end
  
  def edit_multiple
  params[:q] = Rails.cache.read("q")
  @search = Product.search(params[:q])  
  if params[:selectAll] == "selectAll"
  @products = @search.result
  else
  @products = Product.find(params[:product_ids])
  end
  end
  
  def update_multiple
  @products = Product.find(params[:product_ids])
  @products.each do |product|
    product.update_attributes!(params[:product].reject { |k,v| v.blank? })
  end
  flash[:notice] = "Updated products!"
  redirect_to products_path
  end
  

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_product
      @product = Product.find(params[:id])
    end
    

    # Only allow a trusted parameter "white list" through.
    def product_params
      params.require(:product).permit(:inid, :sku ,:title, :short_description, :quantity, :cost_price, :sell_price, :price, :category_id, :variant_id, :homyproduct_id, :emag_id, :rrc_id, :angel_id, :energy_id, :vimcom_id, :ipmatika_id, :sskom_id, :treolan_id, :citilink_id, :iorder_id, :store_id,:variants_attributes =>[:id, :product_id, :sku, :quantity, :price, :cost_price, :old_price, :weight, :product_option_id, :supplier_id, :_destroy])
    end
end
