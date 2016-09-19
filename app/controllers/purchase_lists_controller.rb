class PurchaseListsController < ApplicationController
  
  autocomplete :product, :title, full: true,  :extra_data => [:id]
  before_action :set_purchase_list, only: [:show, :edit, :update, :destroy]
  before_action :authorize
  
  def authorize
    if current_user.nil?
      redirect_to login_url, alert: "Not authorized! Please log in."
     end
  end
 
  # GET /purchase_lists
  # GET /purchase_lists.json
  def index
   @search = PurchaseList.ransack(params[:q]) 
     @search.sorts = 'date desc' if @search.sorts.empty? 
     @purchase_lists = @search.result.paginate(page: params[:page], per_page: 30)
  end

  # GET /purchase_lists/1
  # GET /purchase_lists/1.json
  def show
  end

  # GET /purchase_lists/new
  def new
    @purchase_list = PurchaseList.new
    @purchase_list.build_purchase_invoice_in
  end

  # GET /purchase_lists/1/edit
  def edit
  @purchase_invoice_in = @purchase_list.purchase_invoice_in || @purchase_list.build_purchase_invoice_in
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
  @purchase_list = PurchaseList.find(params[:id])
  
  respond_to do |format|      
	 
	if @purchase_list.update(purchase_list_params) 

      if @purchase_list.purchase_invoicein_check == true
      
		@purchase_list.purchase_list_items.each do |pli|
		quantity = pli["quantity"]
		price = pli["price"]
		title = pli["title"]
		sum = pli["sum"]
		product = Product.find_by_title("#{title}")
		prid = product["id"]
		pli.update_attributes("quantity" => quantity, "price" => price, "product_id" => prid, sum: sum )
		end
      
      #добавляем в талицу stock данные из перечня товаров в накладной по позициям
		@purchase_list.purchase_list_items.each do |pli| 
		stock = Stock.where(product_id: pli.product_id, purchase_list_id: @purchase_list.id)
			if stock.present?  #если запись в таблице stock есть, то обновляем кол-во и цену
				stock.each do |stock|
				stock.quantity = pli.quantity
				stock.price = pli.price
				stock.save
				end
			
			else
				@stock = @purchase_list.stocks.create(product_id: pli.product_id, purchase_list_id: @purchase_list.id, quantity: pli.quantity, price: pli.price)
			end
	    end
	    
	    #работаем с stock и записываем в позиции айди позиции нашего склада(store)
		@purchase_list.purchase_list_items.each do |pli|
		store = Store.find_by_title(pli.title)
		if store.present?
		stock = Stock.where(product_id: pli.product_id)
		stock.each do |stock|
		stock.store_id = store.id
		stock.save
		end
		else
		store = Store.create(title: pli.title)
		stock = Stock.where(product_id: pli.product_id)
		stock.each do |stock|
		stock.store_id = store.id
		stock.save
		stock.product.store_id = store.id
		stock.product.save
		end
		end
		end
      #удаляем одну из позиций в таблице stock, если удаляется позиция в накладной
      if @purchase_list.stocks.size > @purchase_list.purchase_list_items.size
	      @purchase_list.stocks.each do |pls|
	      a = @purchase_list.purchase_list_items.where(product_id: pls.product_id)
		      if !a.present? #если запись в таблице "позиции в накладной" отсутствует, то удаляем запись в таблице stock
		      pls.destroy
		      end
	      end
      end
      
      @purchase_list.purchase_invoice_in.save # это конец от объявления действия build в методе edit
      end #конец if = true
      
      
      if @purchase_list.purchase_invoicein_check == false
      @purchase_list.purchase_invoice_in.destroy
      #удаляем позиции в таблице stock, если накладная не проведена (не стоит галка записать счет-фактуру)
	      @purchase_list.stocks.each do |pls|
		      pls.destroy
	      end
	  end

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
  #@purchase_list.purchase_invoice_in.destroy
  @purchase_list.stocks.each do |stock|
  stock.destroy
  end
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
      params.require(:purchase_list).permit(:number, :date, :company_id, :total_price, :status, :purchase_invoicein_check,:purchase_list_items_attributes =>[:id, :product_id, :title, :quantity, :price, :sum, :_destroy], :purchase_invoice_in_attributes =>[:id,:number, :data, :purchase_list_id, :_destroy]) 
    end
end
