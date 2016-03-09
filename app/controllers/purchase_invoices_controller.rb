class PurchaseInvoicesController < ApplicationController

  before_action :set_purchase_invoice, only: [:show, :edit, :update, :destroy]
  before_action :authorize
  autocomplete :product, :title, full: true,  :extra_data => [:id]
  autocomplete :company, :title, full: true,  :extra_data => [:inn]
    
  def authorize
    if current_user.nil?
      redirect_to login_url, alert: "Not authorized! Please log in."
     end
  end
  # GET /purchase_invoices
  # GET /purchase_invoices.json
  def index
     @search = PurchaseInvoice.ransack(params[:q]) 
     @search.sorts = 'number desc' if @search.sorts.empty? 
     @purchase_invoices = @search.result.paginate(page: params[:page], per_page: 30) 
  end

  # GET /purchase_invoices/1
  # GET /purchase_invoices/1.json
  def show
  end

  # GET /purchase_invoices/new
  def new
    @purchase_invoice = PurchaseInvoice.new
  end

  # GET /purchase_invoices/1/edit
  def edit
  end

  # POST /purchase_invoices
  # POST /purchase_invoices.json
  def create
    @purchase_invoice = PurchaseInvoice.new(purchase_invoice_params)
    if @purchase_invoice.save
    
      redirect_to @purchase_invoice, notice: 'purchase_invoice was successfully created.'
    else
      render :new
    end
    
  end

  # PATCH/PUT /purchase_invoices/1
  # PATCH/PUT /purchase_invoices/1.json
  def update
    respond_to do |format|
      if @purchase_invoice.update(purchase_invoice_params)
      
      @purchase_invoice.purchase_invoice_items.each do |pii| # не могу вспомнить зачем я это делаю (наверное чтобы записать product_id)
  	  line = PurchaseInvoiceItem.where("title" => "#{pii["title"]}", "purchase_invoice_id" => "#{@purchase_invoice.id}")
  	  line.each do |line|
  	  title = pii["title"]
  	  product = Product.find_by_title("#{title}")
  	  line.product_id = product.id
  	  line.save
  	  end
  	  end
      
      @purchase_invoice.total_price = @purchase_invoice.purchase_invoice_items.sum(:sum)
      @purchase_invoice.save
      
      if @purchase_invoice.purchase_list_check == true
      @purchase_list = @purchase_invoice.purchase_lists.create(number: @purchase_invoice.number, date: @purchase_invoice.date, company_id: @purchase_invoice.company_id, total_price: @purchase_invoice.total_price)
      @purchase_invoice.purchase_invoice_items.each do |pii|
      @purchase_list_item = PurchaseListItem.create("title" => "#{pii.title}", "quantity" => "#{pii.quantity}", "product_id" => "#{pii.product_id}", "price" => "#{pii.price}", "sum" => "#{pii.sum}", purchase_list_id: @purchase_list.id)
      end
      end
        format.html { redirect_to @purchase_invoice, notice: 'Purchase invoice was successfully updated.' }
        format.json { render :show, status: :ok, location: @purchase_invoice }
      else
        format.html { render :edit }
        format.json { render json: @purchase_invoice.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /purchase_invoices/1
  # DELETE /purchase_invoices/1.json
  def destroy
    @purchase_invoice.destroy
    respond_to do |format|
      format.html { redirect_to purchase_invoices_url, notice: 'Purchase invoice was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_purchase_invoice
      @purchase_invoice = PurchaseInvoice.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def purchase_invoice_params
      params.require(:purchase_invoice).permit(:number, :date, :company_id, :total_price, :status, :purchase_list_check,:purchase_invoice_items_attributes =>[:id, :product_id, :title, :quantity, :price, :sum, :_destroy])
    end
end
