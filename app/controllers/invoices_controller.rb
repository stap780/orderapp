class InvoicesController < ApplicationController
  
  before_action :set_invoice, only: [:show, :print, :edit, :update, :destroy]
  before_action :authorize
  autocomplete :company, :title, full: true	

  
  def authorize
    if current_user.nil?
      redirect_to login_url, alert: "Not authorized! Please log in."
     end
  end
  # GET /invoices
  # GET /invoices.json
  def index
     @search = Invoice.ransack(params[:q]) #используется gem ransack для поиска и сортировки
     @search.sorts = 'number desc' if @search.sorts.empty? # сортировка таблицы по номеру по умолчанию 
     @invoices = @search.result.paginate(page: params[:page], per_page: 30)   
  end

  # GET /invoices/1
  # GET /invoices/1.json
  def show
  @company2 = Company.find_by_id(@invoice.companytwo)
  end
  
  def print
  	@nds =  (@invoice.invoice_items.sum(:sum)*18/118).to_f.round(2)
  	@skidka = @invoice.invoice_items.sum(:sum) * @invoice.discount.to_i/100
  	@company2 = Company.find_by_id(@invoice.companytwo)
  	respond_to do |format|
		format.html # show.html.erb
		    format.pdf do
		      render :pdf => "Счёт #{@invoice.number}",
		             :template => "invoices/pdfsight"
		    end 
		end
  end
  
	def pdf
	@invoice = Invoice.find_by_id(params[:invoice_id])
	@nds =  (@invoice.invoice_items.sum(:sum)*18/118).to_f.round(2)
	@skidka = @invoice.invoice_items.sum(:sum) * @invoice.discount.to_i/100
	@company2 = Company.find_by_id(@invoice.companytwo)
	      render :pdf => "Счёт #{@invoice.number}",
	             :template => "invoices/pdf"
	end

  # GET /invoices/new
  def new
    @invoice = Invoice.new
    @invoice.invoice_items.build
  end

  # GET /invoices/1/edit
  def edit
  end

  # POST /invoices
  # POST /invoices.json
  def create
    @invoice = Invoice.new(invoice_params)

    respond_to do |format|
      if @invoice.save
        format.html { redirect_to @invoice, notice: 'Invoice was successfully created.' }
        format.json { render :show, status: :created, location: @invoice }
      else
        format.html { render :new }
        format.json { render json: @invoice.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /invoices/1
  # PATCH/PUT /invoices/1.json
  def update
    respond_to do |format|
    
    @invoice = Invoice.find(params[:id])
      if @invoice.update(invoice_params)
      
      @invoice.invoice_items.each do |li| #обновляем поля у товаров и пересчитываем сумму при обновлении или создаём новую позицию в счёте
      if li.present?
      quantity = li["quantity"]
      price = li["price"]
      sum = quantity * price
      title = li["title"]
  	  product = Product.find_by_title("#{title}")
  	  prid = product["id"]
  	  li.update_attributes("quantity" => quantity, "price" => price, "sum" => sum)
	  else
	  @invoice_item = li.create("title" => product["title"], "quantity"=> quantity , "price" => price, "sum" => sum,"product_id" =>"#{prid}")
   	  
  	  end
     end
     
     @invoice.invoice_items.each do |li| # не могу вспомнить зачем я это делаю (наверное чтобы записать product_id)
	  title = li["title"]
  	  product = Product.find_by_title("#{title}")
  	  line = LineItem.where("title" => "#{title}", "invoice_id" => "#{@invoice.id}")
  	  line.each do |line|
  	  line.product_id = product.id
  	  line.save
  	  end
  	  end
	  
  	#@invoice.total_price = @invoice.invoice_items.sum(:sum) - @invoice.invoice_items.sum(:sum) * @invoice.discount.to_i/100 
  	#@invoice.save
  	
  	# создаем накладную и записывыем id накладной в позиции относящиеся к счету
     if @invoice.invoice_list_check == true 
     @invoice_list = @invoice.invoice_lists.build(number: @invoice.number, date: @invoice.updated_at, client_id: @invoice.client_id, company_id: @invoice.company_id, discount: @invoice.discount, total_price: @invoice.total_price)
     @invoice_list.save
     #создаем позиции в накладной в таблице позиции-накладной
     @invoice.invoice_items.each do |li| 
     @invoice_list_item = InvoiceListItem.create("title" => "#{li.title}", "quantity" => "#{li.quantity}", "product_id" => "#{li.product_id}", "price" => "#{li.price}", "sum" => "#{li.sum}", invoice_list_id: @invoice_list.id)
     end
     end 
      
        format.html { redirect_to @invoice, notice: 'Invoice was successfully updated.' }
        format.json { render :show, status: :ok, location: @invoice }
      else
        format.html { render :edit }
        format.json { render json: @invoice.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /invoices/1
  # DELETE /invoices/1.json
  def destroy
    @invoice.destroy
    respond_to do |format|
      format.html { redirect_to invoices_url, notice: 'Invoice was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_invoice
      @invoice = Invoice.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def invoice_params
      params.require(:invoice).permit(:number, :date, :client_id,:company_id, :companytwo, :invstatus, :invoice_list_check, :iorder_id, :discount, :total_price,:invoice_items_attributes =>[:id, :product_id, :title, :quantity, :price, :iorder_id, :sum, :invoice_list_id, :_destroy])
    end
end
