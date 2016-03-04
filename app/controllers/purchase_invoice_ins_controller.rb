class PurchaseInvoiceInsController < ApplicationController
  before_action :set_purchase_invoice_in, only: [:show, :edit, :update, :destroy]

  # GET /purchase_invoice_ins
  # GET /purchase_invoice_ins.json
  def index
    @search = PurchaseInvoiceIn.ransack(params[:q]) 
     @search.sorts = 'number desc' if @search.sorts.empty? 
     @purchase_invoice_ins = @search.result.paginate(page: params[:page], per_page: 30)
  end

  # GET /purchase_invoice_ins/1
  # GET /purchase_invoice_ins/1.json
  def show
  end

  # GET /purchase_invoice_ins/new
  def new
    @purchase_invoice_in = PurchaseInvoiceIn.new
    
  end

  # GET /purchase_invoice_ins/1/edit
  def edit
  end

  # POST /purchase_invoice_ins
  # POST /purchase_invoice_ins.json
  def create
    @purchase_invoice_in = PurchaseInvoiceIn.new(purchase_invoice_in_params)

    respond_to do |format|
      if @purchase_invoice_in.save
        format.html { redirect_to @purchase_invoice_in, notice: 'Purchase invoice in was successfully created.' }
        format.json { render :show, status: :created, location: @purchase_invoice_in }
      else
        format.html { render :new }
        format.json { render json: @purchase_invoice_in.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /purchase_invoice_ins/1
  # PATCH/PUT /purchase_invoice_ins/1.json
  def update
    respond_to do |format|
      if @purchase_invoice_in.update(purchase_invoice_in_params)
        format.html { redirect_to @purchase_invoice_in, notice: 'Purchase invoice in was successfully updated.' }
        format.json { render :show, status: :ok, location: @purchase_invoice_in }
      else
        format.html { render :edit }
        format.json { render json: @purchase_invoice_in.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /purchase_invoice_ins/1
  # DELETE /purchase_invoice_ins/1.json
  def destroy
    @purchase_invoice_in.destroy
    respond_to do |format|
      format.html { redirect_to purchase_invoice_ins_url, notice: 'Purchase invoice in was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_purchase_invoice_in
      @purchase_invoice_in = PurchaseInvoiceIn.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def purchase_invoice_in_params
      params.require(:purchase_invoice_in).permit(:number, :data, :purchase_list_id)
    end
end
