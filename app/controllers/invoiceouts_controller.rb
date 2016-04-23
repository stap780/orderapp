class InvoiceoutsController < ApplicationController
  before_action :set_invoiceout, only: [:show, :edit, :update, :destroy]

  # GET /invoiceouts
  # GET /invoiceouts.json
  def index
     @search = Invoiceout.ransack(params[:q]) 
     @search.sorts = 'number desc' if @search.sorts.empty?
     @invoiceouts = @search.result.paginate(page: params[:page], per_page: 30) 
  end

  # GET /invoiceouts/1
  # GET /invoiceouts/1.json
  def show
  end

  # GET /invoiceouts/new
  def new
    @invoiceout = Invoiceout.new
  end

  # GET /invoiceouts/1/edit
  def edit
  end

  # POST /invoiceouts
  # POST /invoiceouts.json
  def create
    @invoiceout = Invoiceout.new(invoiceout_params)

    respond_to do |format|
      if @invoiceout.save
        format.html { redirect_to @invoiceout, notice: 'Invoiceout was successfully created.' }
        format.json { render :show, status: :created, location: @invoiceout }
      else
        format.html { render :new }
        format.json { render json: @invoiceout.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /invoiceouts/1
  # PATCH/PUT /invoiceouts/1.json
  def update
    respond_to do |format|
      if @invoiceout.update(invoiceout_params)
        format.html { redirect_to @invoiceout, notice: 'Invoiceout was successfully updated.' }
        format.json { render :show, status: :ok, location: @invoiceout }
      else
        format.html { render :edit }
        format.json { render json: @invoiceout.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /invoiceouts/1
  # DELETE /invoiceouts/1.json
  def destroy
    @invoiceout.destroy
    respond_to do |format|
      format.html { redirect_to invoiceouts_url, notice: 'Invoiceout was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_invoiceout
      @invoiceout = Invoiceout.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def invoiceout_params
      params.require(:invoiceout).permit(:number, :date, :company_id, :invoice_list_id, :total_price, :nds, :payment)
    end
end
