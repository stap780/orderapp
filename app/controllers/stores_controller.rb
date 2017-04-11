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
  	if params[:q] !=nil
	    @startdate = params[:q][:stocks_created_at_gteq].to_date.beginning_of_day 
	    @enddate = params[:q][:stocks_created_at_lteq].to_date.end_of_day 
		else
	    @startdate = '2015-01-01'.to_date.beginning_of_day 
	    @enddate = Date.current 
		end
	
    @q = Store.ransack(params[:q]) 
    @q.sorts = 'title asc' if @q.sorts.empty? 
    @stores = @q.result(distinct: true).includes(:stocks).paginate(page: params[:page], per_page: 20)
    # расчет кол-ва для сохранения в базе и проверки с отображением во view
    @stores.each do |store|
    purchase_prihod = store.stocks.where("purchase_list_id IS NOT ? ", nil)
    enter_prihod = store.stocks.where("enter_id IS NOT ?", nil)
    vozvrat = store.stocks.where("vozvrat_id IS NOT ?", nil)
    invoice_rashod = store.stocks.where("invoice_list_id IS NOT ?", nil)
    loss_rashod = store.stocks.where("loss_id IS NOT ?", nil)
    prihod = purchase_prihod.sum(:quantity).to_i + enter_prihod.sum(:quantity).to_i 
    rashod = invoice_rashod.sum(:quantity).to_i + loss_rashod.sum(:quantity).to_i
    store.quantity = prihod - rashod + vozvrat.sum(:quantity).to_i
    store.save
			
    #расчет цен по приходу и расходу
    # средняя цена прихода
    pprihod = (purchase_prihod.sum(:price)/purchase_prihod.count).to_f.round(2)
	  penter = (enter_prihod.sum(:price)/enter_prihod.count).to_f.round(2)
		if penter.nan?
		penter = 0
		end
		if pprihod.nan?
		pprihod = 0
		end
		if penter || pprihod == 0
		pricein = (penter+pprihod)/1
		else
		pricein = (penter+pprihod)/2
		end
		store.pricein = pricein
		store.save
		# средняя цена расхода
		prashod = (invoice_rashod.sum(:price)/invoice_rashod.count).to_f.round(2)
		ploss = (loss_rashod.sum(:price)/loss_rashod.count).to_f.round(2)
		if ploss.nan?
		ploss = 0
		end
		if prashod.nan?
		prashod = 0
		end
		if ploss || prashod == 0
		price = (prashod+ploss)/1
		else
		price = (prashod+ploss)/2
		end
		store.price = price
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
      params.require(:store).permit(:title, :quantity, :price)
    end
end
