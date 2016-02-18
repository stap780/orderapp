class PurchaseInvoicesController < ApplicationController

	autocomplete :product, :title, full: true,  :extra_data => [:id]
  before_action :set_purchase_invoice, only: [:show, :edit, :update, :destroy]

  # GET /purchase_invoices
  # GET /purchase_invoices.json
  def index
    @purchase_invoices = PurchaseInvoice.all
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
	  title = pii["title"]
  	  product = Product.find_by_title("#{title}")
  	  line = PurchaseInvoiceItem.where("title" => "#{title}", "purchase_invoice_id" => "#{@purchase_invoice.id}")
  	  line.each do |line|
  	  line.product_id = product.id
  	  line.save
  	  end
  	  end
      
      @purchase_invoice.total_price = @purchase_invoice.purchase_invoice_items.sum(:sum)
      @purchase_invoice.save
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
      params.require(:purchase_invoice).permit(:number, :date, :company_id, :total_price,:purchase_invoice_items_attributes =>[:id, :product_id, :title, :quantity, :price, :sum, :_destroy])
    end
end
