# -*- encoding : utf-8 -*-
class ProductsController < ApplicationController
 
  require 'open-uri'
  require 'nokogiri'
  require 'rest-client'

  before_action :set_product, only: [:show, :edit, :update, :destroy]
  before_action :authorize
	
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
