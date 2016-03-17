class IordersController < ApplicationController
    require 'open-uri'
    require 'nokogiri'
    require 'rest_client'
    
    
    autocomplete :product, :title, full: true 
	before_action :set_iorder, only: [:show, :print, :edit, :update, :destroy]
	before_action :authorize
	
  def authorize
    if current_user.nil?
      redirect_to login_url, alert: "Not authorized! Please log in."
     end
  end
  
  # GET /iorders
  def index
     @search = Iorder.ransack(params[:q]) #используется gem ransack для поиска и сортировки
     @search.sorts = 'number desc' if @search.sorts.empty? # сортировка таблицы по номеру по умолчанию 
     @iorders = @search.result.paginate(page: params[:page], per_page: 30)
  end

  # GET /iorders/1
  def show
  json = { :success => true }.to_json
    respond_to do |format|
    format.html # show.html.erb
    format.xml  { render :xml => @iorder }
    format.json  { render :json => @iorder }
    format.js { render :json => json, :callback => params[:callback] }
    end
  end
  
  def print
  	@nds =  @iorder.line_items.sum(:sum)*18/100
  	@skidka = @iorder.line_items.sum(:sum) * @iorder.discount_percent.to_i/100
  end

  # GET /iorders/new
  def new
    @iorder = Iorder.new
  end

  # GET /iorders/1/edit
  def edit
	  @iorder = Iorder.find(params[:id])
	  
  end

  # POST /iorders
  def create
    @iorder = Iorder.new(iorder_params)
    if @iorder.save
    
      redirect_to @iorder, notice: 'Iorder was successfully created.'
    else
      render :new
    end
  end

  # GET /iorders/downloadorder
  def downloadorder 
    @iorder = Iorder.downloadorder
    flash[:notice] = 'Orders was successfully downloaded'
    redirect_to iorders_path
  end
  
  def updateorder
    @iorder = Iorder.updateorder
    flash[:notice] = 'Orders was successfully updated'
    redirect_to iorders_path
  end
  
  def checkdelivery
  @iorder = Iorder.checkdelivery
    flash[:notice] = 'Delivery status was successfully checked'
    redirect_to iorders_path
  end

  # PATCH/PUT /iorders/1
  def update
  	@iorder = Iorder.find(params[:id])
    if @iorder.update(iorder_params)
    
    @iorder.line_items.each do |li|
	  li.sum = li.price * li.quantity
	  li.save
	  product = Product.find_by_title("#{li.title}")
	  li.product_id = product.id
	  li.save
	 end
	  
  	@iorder.total_price = @iorder.line_items.sum(:sum) - @iorder.line_items.sum(:sum) * @iorder.discount_percent.to_i/100 + @iorder.deliveryprice.to_i
  	@iorder.save
  	
  	# создаем счет и записывыем id счета в позиции относящиеся к заказу
     if @iorder.invoice_check == true   
     @invoice = @iorder.create_invoice(number: @iorder.number, date: @iorder.updated_at, client_id: @iorder.client_id, discount: @iorder.discount_percent, iorder_id: @iorder.id, company_id: 59)
     # @iorder.line_items.each do |li| 
     # if !li.invoice_id.present?
     # li.invoice_id = @invoice.id
     # @iorder.save
     # end
     #end
     #создаем позиции к счету в таблице позиции-счета
     @iorder.line_items.each do |li| #создаём позиции в счете
     @invoice_item = InvoiceItem.create("title" => "#{li.title}", "quantity" => "#{li.quantity}", "product_id" => "#{li.product_id}", "price" => "#{li.price}", "sum" => "#{li.sum}", invoice_id: @invoice.id)
     end 
     end

     # Создание записи по курьерке
     if  @iorder.mycourier_id == 1 
     @iml = @iorder.create_iml(number: @iorder.number)
     if @iorder.iml_id.present? 
     @iorder.iml_id = @iorder.iml.id
     @iorder.save
     end
     end
     if  @iorder.mycourier_id == 2 
     @dpd = @iorder.create_dpd(numer: @iorder.number)
     if @iorder.dpd_id.present? 
     @iorder.dpd_id = @iorder.dpd.id
     @iorder.save
     end 
     end
     if  @iorder.mycourier_id == 3 
     @courier = @iorder.create_courier(number: @iorder.number)
     if @iorder.courier_id.present? 
     @iorder.courier_id = @iorder.courier.id
     @iorder.save
     end 
     end
     if  @iorder.mycourier_id == 5 
     @post = @iorder.create_post(number: @iorder.number)
     if @iorder.post_id.present? 
     @iorder.post_id = @iorder.post.id
     @iorder.save
     end 
     end
      #_______________________ 
     
     
     
    redirect_to @iorder, notice: 'Order was successfully updated.'
   
    else
      render :edit
    end
    
  end

  # DELETE /iorders/1
  def destroy
    @iorder.destroy
    redirect_to iorders_url, notice: 'Iorder was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_iorder
      @iorder = Iorder.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def iorder_params
      params.require(:iorder).permit(:number, :instatus, :financial, :payment,:clientname, :client, :client_middlename, :client_surname, :delivery, :shipping_zip, :shipping_city, :shipping_address, :phone, :email, :total, :orderstatus_id, :status_id, :mycourier_id, :iml_id, :dpd_id, :post_id, :courier_id, :variantid, :quantity, :price, :deliveryprice, :discount_percent, :total_price, :client_id, :invoice_id, :invoice_check,:line_items_attributes =>[:id, :product_id, :title, :quantity, :price, :iorder_id, :sum, :invoice_id, :_destroy])
       
    end
    
    
end
