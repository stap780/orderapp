class StoresController < ApplicationController
  before_action :set_store, only: [:show, :edit, :update, :destroy]
  before_action :authorize
  autocomplete :product, :title, full: true,  :extra_data => [:id]
  
  
  def authorize
    if current_user.nil?
      redirect_to login_url, alert: "Not authorized! Please log in."
     end
  end
  # GET /stores
  # GET /stores.json
  def index
  
    @q = Store.ransack(params[:q]) 
    @q.sorts = 'title asc' if @q.sorts.empty? 
    @stores = @q.result.paginate(page: params[:page], per_page: 50)
    @stores.each do |store|
    purchase_prihod = store.stocks.where("purchase_list_id IS NOT ?", nil)
    enter_prihod = store.stocks.where("enter_id IS NOT ?", nil)
    invoice_rashod = store.stocks.where("invoice_list_id IS NOT ?", nil)
    loss_rashod = store.stocks.where("loss_id IS NOT ?", nil)
    prihod = purchase_prihod.sum(:quantity).to_i + enter_prihod.sum(:quantity).to_i
    rashod = invoice_rashod.sum(:quantity).to_i + loss_rashod.sum(:quantity).to_i
    store.quantity = prihod - rashod
    store.save
    end
  end
  
  def search
  index
  render :index
  end

  # GET /stores/1
  # GET /stores/1.json
  def show
  end

  # GET /stores/new
  def new
    @store = Store.new
  end

  # GET /stores/1/edit
  def edit
  end

  # POST /stores
  # POST /stores.json
  def create
    @store = Store.new(store_params)
    respond_to do |format|
      if @store.save  
       #  @product = Product.find_by_title(@store.title)
#       @product.store_id = @store.id
#       @product.save
        format.html { redirect_to @store, notice: 'Store was successfully created.' }
        format.json { render :show, status: :created, location: @store }
      else
        format.html { render :new }
        format.json { render json: @store.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /stores/1
  # PATCH/PUT /stores/1.json
  def update
    respond_to do |format|
      if @store.update(store_params)
        format.html { redirect_to @store, notice: 'Store was successfully updated.' }
        format.json { render :show, status: :ok, location: @store }
      else
        format.html { render :edit }
        format.json { render json: @store.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /stores/1
  # DELETE /stores/1.json
  def destroy
    @store.destroy
    respond_to do |format|
      format.html { redirect_to stores_url, notice: 'Store was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_store
      @store = Store.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def store_params
      params.require(:store).permit(:title, :quantity, :price, :product_id)
    end
end
