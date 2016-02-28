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
    @totalproducts = Product.count
    @totalproductssku = Product.where("cast(sku as integer) > ?", 0).count
    @zeroquantity = Product.where("cast(quantity as integer) = ?", 0).count
    @qnotzero = Product.where("cast(quantity as integer) > ?", 0).count
    @products_all = Product.all
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
  
  # PATCH/PUT /products/1
  def update
    if @product.update(product_params)
    # uri = "http://a2e2ed5ba6560944845dbf38f2223298:0e734e3c93ca9795f87313c83c5ebbcf@worksys.myinsales.ru/admin/products/#{(@product.inid)}/variants/#{(@product.variant_id)}.xml"
#     begin
#       response = RestClient.put uri, "<variant><quantity>#{(@product.quantity)}</quantity></variant>", :accept => :xml, :content_type => "application/xml"
#       flash[:notice] = "Product was successfully updated."
#     rescue Exception => e
#       flash[:error] = "Product Failed to Update"
#     end
#     
#       redirect_to @product
      
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

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_product
      @product = Product.find(params[:id])
    end
    

    # Only allow a trusted parameter "white list" through.
    def product_params
      params.require(:product).permit(:inid, :sku ,:title, :short_description, :quantity, :cost_price, :price, :category_id, :variant_id, :homyproduct_id, :emag_id, :rrc_id, :angel_id, :energy_id, :vimcom_id, :ipmatika_id, :sskom_id, :treolan_id, :citilink_id, :iorder_id)
    end
end
