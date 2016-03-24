class LossesController < ApplicationController
	
  before_action :set_loss, only: [:show, :edit, :update, :destroy]
  before_action :authorize
  autocomplete :product, :title, full: true,  :extra_data => [:sku]

  def authorize
    if current_user.nil?
      redirect_to login_url, alert: "Not authorized! Please log in."
     end
  end

  # GET /losses
  # GET /losses.json
  def index
    @losses = Loss.all
  end

  # GET /losses/1
  # GET /losses/1.json
  def show
  end

  # GET /losses/new
  def new
    @loss = Loss.new
    #@loss.store_items.build
  end

  # GET /losses/1/edit
  def edit
  end

  # POST /losses
  # POST /losses.json
  def create
    @loss = Loss.new(loss_params)

    respond_to do |format|
      if @loss.save
      
      @loss.store_items.each do |lsi|
		quantity = lsi["quantity"]
		price = lsi["price"]
		title = lsi["title"]
		sum = lsi["sum"]
		product = Product.find_by_title("#{title}")
		prid = product["id"]
		lsi.update_attributes("quantity" => quantity, "price" => price, "product_id" => prid, sum: sum )
		end
		
      #добавляем в талицу stock данные из перечня товаров в накладной по позициям
		@loss.store_items.each do |si| 
		stock = Stock.where(product_id: si.product_id, loss_id: @loss.id)
			if stock.present?  #если запись в таблице stock есть, то обновляем кол-во и цену
				stock.each do |stock|
				stock.quantity = si.quantity
				stock.price = si.price
				stock.save
				end
			
			else
				@stock = @loss.stocks.create(product_id: si.product_id, loss_id: @loss.id, quantity: si.quantity, price: si.price)
			end
	    end
	    
	    #работаем с stock и записываем в позиции айди позиции нашего склада(store)
		@loss.store_items.each do |si|
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
      if @loss.stocks.size > @loss.store_items.size
	      @loss.stocks.each do |pls|
	      a = @loss.store_items.where(product_id: pls.product_id)
		      if !a.present? #если запись в таблице "позиции в накладной" отсутствует, то удаляем запись в таблице stock
		      pls.destroy
		      end
	      end
      end
            
        format.html { redirect_to @loss, notice: 'Loss was successfully created.' }
        format.json { render :show, status: :created, location: @loss }
      else
        format.html { render :new }
        format.json { render json: @loss.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /losses/1
  # PATCH/PUT /losses/1.json
  def update
    respond_to do |format|
      if @loss.update(loss_params)
      
      @loss.store_items.each do |lsi|
		quantity = lsi["quantity"]
		price = lsi["price"]
		title = lsi["title"]
		sum = lsi["sum"]
		product = Product.find_by_title("#{title}")
		prid = product["id"]
		lsi.update_attributes("quantity" => quantity, "price" => price, "product_id" => prid, sum: sum )
		end
      
       #добавляем в талицу stock данные из перечня товаров в накладной по позициям
		@loss.store_items.each do |si| 
		stock = Stock.where(product_id: si.product_id, loss_id: @loss.id)
			if stock.present?  #если запись в таблице stock есть, то обновляем кол-во и цену
				stock.each do |stock|
				stock.quantity = si.quantity
				stock.price = si.price
				stock.save
				end
			
			else
				@stock = @loss.stocks.create(product_id: si.product_id, loss_id: @loss.id, quantity: si.quantity, price: si.price)
			end
	    end
	    
	    #работаем с stock и записываем в позиции айди позиции нашего склада(store)
		@loss.store_items.each do |si|
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
      if @loss.stocks.size > @loss.store_items.size
	      @loss.stocks.each do |pls|
	      a = @loss.store_items.where(product_id: pls.product_id)
		      if !a.present? #если запись в таблице "позиции в накладной" отсутствует, то удаляем запись в таблице stock
		      pls.destroy
		      end
	      end
      end
       
        format.html { redirect_to @loss, notice: 'Loss was successfully updated.' }
        format.json { render :show, status: :ok, location: @loss }
      else
        format.html { render :edit }
        format.json { render json: @loss.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /losses/1
  # DELETE /losses/1.json
  def destroy
    @loss.destroy
    respond_to do |format|
      format.html { redirect_to losses_url, notice: 'Loss was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_loss
      @loss = Loss.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def loss_params
      params.require(:loss).permit(:number, :date, :description, :total,:store_items_attributes =>[:id, :product_id, :title, :quantity, :price, :sum, :_destroy])
    end
end
