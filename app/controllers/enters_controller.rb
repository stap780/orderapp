class EntersController < ApplicationController
  before_action :set_enter, only: [:show, :edit, :update, :destroy]
  before_action :authorize
  autocomplete :product, :title, full: true,  :extra_data => [:id]

  def authorize
    if current_user.nil?
      redirect_to login_url, alert: "Not authorized! Please log in."
     end
  end

  # GET /enters
  # GET /enters.json
  def index
    @enters = Enter.all
  end

  # GET /enters/1
  # GET /enters/1.json
  def show
  end

  # GET /enters/new
  def new
    @enter = Enter.new
    #@enter.store_items.build
  end

  # GET /enters/1/edit
  def edit
  end

  # POST /enters
  # POST /enters.json
  def create
    @enter = Enter.new(enter_params)
	
    respond_to do |format|
      if @enter.save
      
      @enter.store_items.each do |lsi|
		quantity = lsi["quantity"]
		price = lsi["price"]
		title = lsi["title"]
		sum = lsi["sum"]
		product = Product.find_by_title("#{title}")
		prid = product["id"]
		lsi.update_attributes("quantity" => quantity, "price" => price, "product_id" => prid, sum: sum )
		end
      
      #добавляем в талицу stock данные из перечня товаров в накладной по позициям
		@enter.store_items.each do |si| 
		stock = Stock.where(product_id: si.product_id, enter_id: @enter.id)
			if stock.present?  #если запись в таблице stock есть, то обновляем кол-во и цену
				stock.each do |stock|
				stock.quantity = si.quantity
				stock.price = si.price
				stock.save
				end
			
			else
				@stock = @enter.stocks.create(product_id: si.product_id, enter_id: @enter.id, quantity: si.quantity, price: si.price)
			end
	    end
	    
	    #работаем с stock и записываем в позиции айди позиции нашего склада(store)
		@enter.store_items.each do |si|
		store = Store.find_by_title(si.title)
		if store.present?
		stock = Stock.where(product_id: si.product_id)
		stock.each do |stock|
		stock.store_id = store.id
		stock.save
		end
		else
		store = Store.create(title: si.title)
		stock = Stock.where(product_id: si.product_id)
		stock.each do |stock|
		stock.store_id = store.id
		stock.save
		stock.product.store_id = store.id
		stock.product.save
		end
		end
		end
		
		#удаляем одну из позиций в таблице stock, если удаляется позиция в накладной
      if @enter.stocks.size > @enter.store_items.size
	      @enter.stocks.each do |pls|
	      a = @enter.store_items.where(product_id: pls.product_id)
		      if !a.present? #если запись в таблице "позиции в накладной" отсутствует, то удаляем запись в таблице stock
		      pls.destroy
		      end
	      end
      end
		
        format.html { redirect_to @enter, notice: 'Enter was successfully created.' }
        format.json { render :show, status: :created, location: @enter }
      else
        format.html { render :new }
        format.json { render json: @enter.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /enters/1
  # PATCH/PUT /enters/1.json
  def update
    respond_to do |format|
      if @enter.update(enter_params)
      
      @enter.store_items.each do |lsi|
		quantity = lsi["quantity"]
		price = lsi["price"]
		title = lsi["title"]
		sum = lsi["sum"]
		product = Product.find_by_title("#{title}")
		prid = product["id"]
		lsi.update_attributes("quantity" => quantity, "price" => price, "product_id" => prid, sum: sum )
		end
      
      #добавляем в талицу stock данные из перечня товаров в накладной по позициям
		@enter.store_items.each do |si| 
		stock = Stock.where(product_id: si.product_id, enter_id: @enter.id)
			if stock.present?  #если запись в таблице stock есть, то обновляем кол-во и цену
				stock.each do |stock|
				stock.quantity = si.quantity
				stock.price = si.price
				stock.save
				end
			
			else
				@stock = @enter.stocks.create(product_id: si.product_id, enter_id: @enter.id, quantity: si.quantity, price: si.price)
			end
	    end
	    
	    #работаем с stock и записываем в позиции айди позиции нашего склада(store)
		@enter.store_items.each do |si|
		store = Store.find_by_title(si.title)
		if store.present?
		stock = Stock.where(product_id: si.product_id)
		stock.each do |stock|
		stock.store_id = store.id
		stock.save
		end
		else
		store = Store.create(title: si.title)
		stock = Stock.where(product_id: si.product_id)
		stock.each do |stock|
		stock.store_id = store.id
		stock.save
		stock.product.store_id = store.id
		stock.product.save
		end
		end
		end
		
		#удаляем одну из позиций в таблице stock, если удаляется позиция в накладной
      if @enter.stocks.size > @enter.store_items.size
	      @enter.stocks.each do |pls|
	      a = @enter.store_items.where(product_id: pls.product_id)
		      if !a.present? #если запись в таблице "позиции в накладной" отсутствует, то удаляем запись в таблице stock
		      pls.destroy
		      end
	      end
      end
      
        format.html { redirect_to @enter, notice: 'Enter was successfully updated.' }
        format.json { render :show, status: :ok, location: @enter }
      else
        format.html { render :edit }
        format.json { render json: @enter.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /enters/1
  # DELETE /enters/1.json
  def destroy
    @enter.destroy
    respond_to do |format|
      format.html { redirect_to enters_url, notice: 'Enter was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_enter
      @enter = Enter.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def enter_params
      params.require(:enter).permit(:number, :date, :description, :total,:store_items_attributes =>[:id, :product_id, :title, :quantity, :price, :sum, :_destroy])
    end
end
