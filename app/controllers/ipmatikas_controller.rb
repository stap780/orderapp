class IpmatikasController < ApplicationController
  before_action :set_ipmatika, only: [:show, :edit, :update, :destroy]
  before_action :authorize
	
  def authorize
    if current_user.nil?
      redirect_to login_url, alert: "Not authorized! Please log in."
     end
  end

  # GET /ipmatikas
  def index
    @ipmatikas = Ipmatika.all
    @search = Ipmatika.ransack(params[:q])
    @search.sorts = 'id asc' if @search.sorts.empty?
    @ipmatikas = @search.result
    @totalipmatikas = Ipmatika.count
    respond_to do |format|
      format.html
      format.csv { send_data @ipmatikas.to_csv }
      format.xls # { send_data @ipmatikas.to_csv(col_sep: "\t") }
    end
  end

  # GET /ipmatikas/1
  def show
  end

  # GET /ipmatikas/new
  def new
    @ipmatika = Ipmatika.new
  end

  # GET /ipmatikas/1/edit
  def edit
  end

  # POST /ipmatikas
  def create
    @ipmatika = Ipmatika.new(ipmatika_params)

    if @ipmatika.save
      redirect_to @ipmatika, notice: 'Ipmatika was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /ipmatikas/1
  def update
    if @ipmatika.update(ipmatika_params)
      redirect_to @ipmatika, notice: 'Ipmatika was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /ipmatikas/1
  def destroy
    @ipmatika.destroy
    redirect_to ipmatikas_url, notice: 'Ipmatika was successfully destroyed.'
  end
  
  def import
    Ipmatika.import(params[:file])
    redirect_to ipmatikas_url, notice: "Products imported."
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_ipmatika
      @ipmatika = Ipmatika.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def ipmatika_params
      params.require(:ipmatika).permit(:sku, :sell_price, :title, :quantity_all, :quantity_res, :quantity_free, :price, :cost_price)
    end
end
