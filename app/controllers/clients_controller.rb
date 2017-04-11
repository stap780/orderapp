class ClientsController < ApplicationController

	autocomplete :company, :inn, full: true,  :extra_data => [:id, :title, :fulltitle]
	before_action :set_client, only: [:show, :edit, :update, :destroy]

  # GET /clients
  def index
    #@clients = Client.all
    @search = Client.ransack(params[:q]) #используется gem ransack для поиска и сортировки
     @search.sorts = 'number desc' if @search.sorts.empty? # сортировка таблицы по номеру по умолчанию 
     @clients = @search.result.paginate(page: params[:page], per_page: 30) 
  end

  # GET /clients/1
  def show
  end

  # GET /clients/new
  def new
    @client = Client.new
    @client.companies.build
  end

  # GET /clients/1/edit
  def edit
  	 @client = Client.find(params[:id])
  	 @client.companies.build
  end

  # POST /clients
  def create
    @client = Client.new(client_params)

    if @client.save
      redirect_to @client, notice: 'Client was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /clients/1
  def update
    if @client.update(client_params)
	    #@client.companies.each do |cc|
	    company = Company.find_by_inn(params["myinn"])
	    if company.present?
	    contragent = Contragent.where("client_id" => @client.id, "company_id" => "#{company.id}")
	    if contragent.empty? 
	    contragent.create("client_id" => @client.id, "company_id" => "#{company.id}")
	    else
	    contragent.each do |c|
	    c.company_id = company.id
 	    c.client_id = @client.id
 	    c.save
	    end
	    end
	    end
      redirect_to @client, notice: 'Client was successfully updated.'
    else
      render :edit
    end
  end
  
  def self.client_name
        self.name
  end
  
	def send_email
		@clients = Client.where(:surname => 'Эмексизов')
		@clients.each do |client|
		ClientMailer.advt_notification(client).deliver_now
		end
		redirect_to clients_url, notice: 'Email sends.'
	end
	
  # DELETE /clients/1
  def destroy
    @client.destroy
    redirect_to clients_url, notice: 'Client was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_client
      @client = Client.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def client_params
      params.require(:client).permit(:name, :middlename, :surname, :phone, :email, :zip, :state, :city, :address, :myinn, :companies_attributes =>[:id, :title, :fulltitle, :uraddress, :factaddress, :inn, :kpp, :ogrn, :okpo, :bik, :banktitle, :bankaccount, :_destroy])
    end
end
