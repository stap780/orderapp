class IordersController < ApplicationController
    require 'open-uri'
    require 'nokogiri'
    require 'rest_client'
    
    after_filter { |controller| handle_jsonp(controller) }
	before_action :set_iorder, only: [:show, :print, :edit, :update, :destroy]
	before_action :authorize
	autocomplete :product, :title, full: true
	autocomplete :client, :name, full: true, :display_value => :client_iorder_name_surname,  :extra_data => [:name, :middlename, :surname, :phone, :email, :zip, :city, :address]
	
	
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
	respond_to do |format|
	format.html
	format.json #{ render :json => @iorders, :callback => params[:mycallback]}
	end

  end
  
  def get_client_data
  @client = Client.where(id: params[:client_id])
    respond_to do |format|
      format.js { render :json => @client}
    end
  end

  # GET /iorders/1
  def show
    respond_to do |format|
    format.html # show.html.erb
    format.xml  { render :xml => @iorder }
    #format.json  { render :json => @iorder }
    format.js
    end
  end
  
  def print
  	@nds =  @iorder.line_items.sum(:sum)*18/100
  	@skidka = @iorder.line_items.sum(:sum) * @iorder.discount_percent.to_i/100
  		respond_to do |format|
				format.html
				format.pdf do
				render :pdf => "Заказ #{@iorder.number}",:template => "iorders/pdf"
				end 

      end

  end

  # GET /iorders/new
  def new
    @iorder = Iorder.new
    respond_to do |format|
      format.html
      format.js
    end
  end

  # GET /iorders/1/edit
  def edit
	  @iorder = Iorder.find(params[:id])
	  
  end

  # POST /iorders
  def create
    @iorder = Iorder.new(iorder_params)
    
    respond_to do |format|
      if @iorder.save
        format.html { redirect_to @iorder, notice: 'Iorder was successfully created.' }
        format.json { render :json => @iorder }
        format.js   { render action: 'show', status: :created, location: @iorder }
      else
        format.html { render action: 'new' }
        format.json { render json: @iorder.errors, status: :unprocessable_entity }
        format.js   { render json: @iorder.errors, status: :unprocessable_entity }
      end
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
  	
  	respond_to do |format|
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
     if @iorder.invoice.nil?
     @invoice = @iorder.create_invoice(number: @iorder.number, date: @iorder.updated_at, client_id: @iorder.client_id, discount: @iorder.discount_percent, iorder_id: @iorder.id)#, company_id: 59, total_price: @iorder.total_price )
     #создаем позиции к счету в таблице позиции-счета
     @iorder.line_items.each do |li| 
     @invoice_item = InvoiceItem.create("title" => "#{li.title}", "quantity" => "#{li.quantity}", "product_id" => "#{li.product_id}", "price" => "#{li.price}", "sum" => "#{li.sum}", invoice_id: @invoice.id)
     end
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
     
     if @iorder.invoice_check == false 
      @iorder.invoice.destroy if @iorder.invoice !=nil
     end
     format.html { redirect_to @iorder, notice: 'Order was successfully updated.' }#redirect_to @iorder
        format.json { render :show, status: :ok, location: @iorder }
        format.js
      else
        format.html { render :edit }
        format.json { render json: @iorder.errors, status: :unprocessable_entity }
      end
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
    
	def handle_jsonp(controller)
	if controller.params[:callback]
	controller.response['Content-Type'] = 'application/javascript'
	controller.response.body = "#{controller.params[:callback]}(#{controller.response.body})"
	end
	end


    # Only allow a trusted parameter "white list" through.
    def iorder_params
      params.require(:iorder).permit(:client_name,:number, :instatus, :financial, :payment,:clientname, :client, :client_middlename, :client_surname, :delivery, :shipping_zip, :shipping_city, :shipping_address, :phone, :email, :total, :orderstatus_id, :status_id, :mycourier_id, :iml_id, :dpd_id, :post_id, :courier_id, :variantid, :quantity, :price, :deliveryprice, :discount_percent, :total_price, :client_id, :invoice_id, :invoice_check,:line_items_attributes =>[:id, :product_id, :title, :quantity, :price, :iorder_id, :sum, :invoice_id, :_destroy])
       
    end
    
    
end
