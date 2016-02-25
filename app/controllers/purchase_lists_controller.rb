class PurchaseListsController < ApplicationController
  
  autocomplete :product, :title, full: true,  :extra_data => [:id]
  before_action :set_purchase_list, only: [:show, :edit, :update, :destroy]

  # GET /purchase_lists
  # GET /purchase_lists.json
  def index
   @search = PurchaseList.ransack(params[:q]) 
     @search.sorts = 'number desc' if @search.sorts.empty? 
     @purchase_lists = @search.result.paginate(page: params[:page], per_page: 30)
  end

  # GET /purchase_lists/1
  # GET /purchase_lists/1.json
  def show
  end

  # GET /purchase_lists/new
  def new
    @purchase_list = PurchaseList.new
  end

  # GET /purchase_lists/1/edit
  def edit
  end

  # POST /purchase_lists
  # POST /purchase_lists.json
  def create
    @purchase_list = PurchaseList.new(purchase_list_params)

    respond_to do |format|
      if @purchase_list.save
        format.html { redirect_to @purchase_list, notice: 'Purchase list was successfully created.' }
        format.json { render :show, status: :created, location: @purchase_list }
      else
        format.html { render :new }
        format.json { render json: @purchase_list.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /purchase_lists/1
  # PATCH/PUT /purchase_lists/1.json
  def update
    respond_to do |format|
      if @purchase_list.update(purchase_list_params)
        format.html { redirect_to @purchase_list, notice: 'Purchase list was successfully updated.' }
        format.json { render :show, status: :ok, location: @purchase_list }
      else
        format.html { render :edit }
        format.json { render json: @purchase_list.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /purchase_lists/1
  # DELETE /purchase_lists/1.json
  def destroy
    @purchase_list.destroy
    respond_to do |format|
      format.html { redirect_to purchase_lists_url, notice: 'Purchase list was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_purchase_list
      @purchase_list = PurchaseList.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def purchase_list_params
      params.require(:purchase_list).permit(:number, :date, :company_id, :total_price, :status, :purchase_invoicein_check,:purchase_list_items_attributes =>[:id, :product_id, :title, :quantity, :price, :sum, :_destroy])
    end
end
