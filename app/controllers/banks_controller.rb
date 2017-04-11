class BanksController < ApplicationController
  before_action :set_bank, only: [:show, :edit, :update, :destroy]
  before_action :authorize
  autocomplete :company, :title, full: true, :case_sensitive => true	
	
  def authorize
    if current_user.nil?
      redirect_to login_url, alert: "Not authorized! Please log in."
     end
  end

  # GET /banks
  # GET /banks.json
  def index
    @q = Bank.ransack(params[:q]) 
    @q.sorts = 'date desc' if @q.sorts.empty? 
    @banks = @q.result.paginate(page: params[:page], per_page: 50)
		@debet = @q.result.where(:oper_type => 'Д').sum(:sum).to_f.round(2)
		@credit = @q.result.where(:oper_type => 'К').sum(:sum).to_f.round(2)
  end
  
  def search
  index
  render :index
  end


  # GET /banks/1
  # GET /banks/1.json
  def show
	  respond_to do |format|
    format.html # show.html.erb
    format.xml  { render :xml => @iorder }
    format.js 
    end
  end

  # GET /banks/new
  def new
    @bank = Bank.new
  end

  # GET /banks/1/edit
  def edit
	  @comp_invoices_payer = @bank.payer.invoices.order("number ASC")
	  @comp_invoices_reciever = @bank.receiver.purchase_invoices.order("number ASC")
	    respond_to do |format|
      format.html
      format.js
    end
  end

  # POST /banks
  # POST /banks.json
  def create
    @bank = Bank.new(bank_params)

    respond_to do |format|
      if @bank.save
        format.html { redirect_to @bank, notice: 'Bank was successfully created.' }
        format.json { render :show, status: :created, location: @bank }
      else
        format.html { render :new }
        format.json { render json: @bank.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /banks/1
  # PATCH/PUT /banks/1.json
  def update
    respond_to do |format|
      if @bank.update(bank_params)
	      
	      @bank.bank_items.each do |bi|
		      if bi.present?
			      bi.update_attributes(:bank_id => @bank.id, :invoice_id => bi["invoice_id"], :purchase_invoice_id => bi["purchase_invoice_id"])
			      else
			      bi.create(:bank_id => @bank.id, :invoice_id => bi["invoice_id"], :purchase_invoice_id => bi["purchase_invoice_id"])
			      end
		    end
	      
	      
        format.html { redirect_to @bank, notice: 'Bank was successfully updated.' }
        format.json { render :show, status: :ok, location: @bank }
        format.js { render action: 'show', status: :created, location: @bank }
      else
        format.html { render :edit }
        format.json { render json: @bank.errors, status: :unprocessable_entity }
        format.js   { render json: @bank.errors, status: :unprocessable_entity }
      end
    end
  end
  
	def import
	Bank.import(params[:file])
	redirect_to banks_url, notice: "imported."
	end


  # DELETE /banks/1
  # DELETE /banks/1.json
  def destroy
    @bank.destroy
    respond_to do |format|
      format.html { redirect_to banks_url, notice: 'Bank was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_bank
      @bank = Bank.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def bank_params
      params.require(:bank).permit(:number, :oper_type, :sum, :description, :date, :payer_id, :receiver_id, :bank_items_attributes => [:id, :bank_id, :invoice_id, :purchase_invoice_id, :_destroy])
    end
end
