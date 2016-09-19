class InvoiceListsController < ApplicationController
  before_action :set_invoice_list, only: [:show, :print, :edit, :update, :destroy]
  before_action :authorize
  
	autocomplete :company, :title, full: true	
  def authorize
    if current_user.nil?
      redirect_to login_url, alert: "Not authorized! Please log in."
     end
  end

  # GET /invoice_lists
  # GET /invoice_lists.json
  def index
     @search = InvoiceList.ransack(params[:q]) #используется gem ransack для поиска и сортировки
     @search.sorts = 'number desc' if @search.sorts.empty? # сортировка таблицы по номеру по умолчанию 
     @invoice_lists = @search.result.paginate(page: params[:page], per_page: 30) 
  end

  # GET /invoice_lists/1
  # GET /invoice_lists/1.json
  def show
  @company2 = Company.find_by_id(@invoice_list.companytwo)
  end
  
  def print
  	@invoice_list = InvoiceList.find(params[:id])
  	@company2 = Company.find_by_id(@invoice_list.companytwo)
  	@nds =  (@invoice_list.total_price - @invoice_list.total_price*100/118).to_f.round(2)
  	@sum_without_nds = (@invoice_list.total_price).to_f - @nds
  	
		respond_to do |format|
			format.html
			format.pdf do
			render :pdf => "УПД #{@invoice_list.number}",
			       :template => "invoice_lists/print" 
			end 
		end
  end
  
	def nakl
	@invoice_list = InvoiceList.find(params[:id])
	@nds =  (@invoice_list.total_price - @invoice_list.total_price*100/118).to_f.round(2)
	
	render :pdf => "Накладная #{@invoice_list.number}",
		     :template => "invoice_lists/nakl" #,:orientation => 'Landscape'
	end

  
  def garant
  	@invoice_list = InvoiceList.find(params[:id])
  	@company2 = Company.find_by_id(@invoice_list.companytwo)
		render :pdf => "Гарантийный талон #{@invoice_list.number}",
			     :template => "invoice_lists/garant" #,:orientation => 'Landscape'
	end


  # GET /invoice_lists/new
  def new
    @invoice_list = InvoiceList.new
  end

  # GET /invoice_lists/1/edit
  def edit
  end

  # POST /invoice_lists
  # POST /invoice_lists.json
  def create
    @invoice_list = InvoiceList.new(invoice_list_params)

    respond_to do |format|
      if @invoice_list.save
        format.html { redirect_to @invoice_list, notice: 'Invoice list was successfully created.' }
        format.json { render :show, status: :created, location: @invoice_list }
      else
        format.html { render :new }
        format.json { render json: @invoice_list.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /invoice_lists/1
  # PATCH/PUT /invoice_lists/1.json
  def update
    respond_to do |format|
      if @invoice_list.update(invoice_list_params)
      
      @invoice_list.invoice_list_items.each do |li| #обновляем поля у товаров и пересчитываем сумму при обновлении или создаём новую позицию в накладной
      quantity = li["quantity"]
      price = li["price"]
      sum = quantity * price
      title = li["title"]
  	  product = Product.find_by_title("#{title}")
  	  prid = product["id"]
  	  li.update_attributes("quantity" => quantity, "price" => price, "sum" => sum, "product_id" => prid)
  	  end
  	  
  	  @invoice_list.total_price = @invoice_list.invoice_list_items.sum(:sum) - @invoice_list.invoice_list_items.sum(:sum) * @invoice_list.discount.to_i/100 
  	  @invoice_list.save
  	  
  	  if @invoice_list.invoiceout_check == true # два больших действия идут далее
  	  
  	  #Действие номер 1
  	  #добавляем в талицу stock данные из перечня товаров в накладной по позициям
  	  @invoice_list.invoice_list_items.each do |ili| 
  	  clear_price = ili.price - ili.price * @invoice_list.discount.to_i/100
  	  stock = Stock.where(product_id: ili.product_id, invoice_list_id: @invoice_list.id)
  	  if stock.present?
  	  stock.each do |stock|
  	  stock.quantity = ili.quantity
  	  stock.price = "#{clear_price}"
  	  stock.save
  	  end
  	  else
  	  @stock = @invoice_list.stocks.create(product_id: ili.product_id, invoice_list_id: @invoice_list.id, quantity: ili.quantity, price: "#{clear_price}")
  	  end
      end
      
      #работаем с stock и записываем в позиции айди позиции нашего склада(store)
		@invoice_list.invoice_list_items.each do |ili|
		store = Store.find_by_title(ili.title)
		if store.present?
		stock = Stock.where(product_id: ili.product_id)
		stock.each do |stock|
		stock.store_id = store.id
		stock.save
		end
		else
		store = Store.create(title: ili.title)
		stock = Stock.where(product_id: ili.product_id)
		stock.each do |stock|
		stock.store_id = store.id
		stock.save
		stock.product.store_id = store.id
		stock.product.save
		end
		end
		end
      
      
      #удаляем одну из позиций в таблице stock, если удаляется позиция в накладной
      if @invoice_list.stocks.size > @invoice_list.invoice_list_items.size
      @invoice_list.stocks.each do |ils|
      a = @invoice_list.invoice_list_items.where(product_id: ils.product_id)
      if !a.present?
      ils.destroy
      end
      end
      end
      
      #Действие номер 2 - добавляем запись о счет-фактуре в таблицу invoiceout
      nds = @invoice_list.total_price - @invoice_list.total_price*100/118
      @invoiceout = @invoice_list.create_invoiceout(number: @invoice_list.number, date: @invoice_list.updated_at, company_id: @invoice_list.company_id, invoice_list_id: @invoice_list.id, total_price: @invoice_list.total_price.to_f.round(2), nds: "#{nds}".to_f.round(2))
      
      else
      
      if @invoice_list.invoiceout_check == false
      @invoiceout = Invoiceout.find_by_number(@invoice_list.number)
	      if @invoiceout.present?
	      @invoiceout.destroy
	      end
      #удаляем одну из позиций в таблице stock, если накладная не проведена
		@invoice_list.stocks.each do |ils|
			ils.destroy
		end
      end
      end
      
      
        format.html { redirect_to @invoice_list, notice: 'Invoice list was successfully updated.' }
        format.json { render :show, status: :ok, location: @invoice_list }
      else
        format.html { render :edit }
        format.json { render json: @invoice_list.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /invoice_lists/1
  # DELETE /invoice_lists/1.json
  def destroy
    @invoice_list.destroy
    respond_to do |format|
    
    # удаляем позиции из таблицы stock при удалении накладной
    @invoice_list.invoice_list_items.each do |ili| 
  	  stock = Stock.where(product_id: ili.product_id, invoice_list_id: @invoice_list.id)
  	  if stock.present?
  	  stock.each do |stock|
  	  stock.destroy
      end
	  end
	  end
    
      format.html { redirect_to invoice_lists_url, notice: 'Invoice list was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_invoice_list
      @invoice_list = InvoiceList.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def invoice_list_params
      params.require(:invoice_list).permit(:number, :date, :status, :total_price, :client_id, :company_id, :discount, :invoiceout_check, :companytwo, :invoice_list_items_attributes =>[:id, :product_id, :title, :quantity, :price, :sum, :invoice_id, :_destroy])
    end
end
