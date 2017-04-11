class RrcsController < ApplicationController
  
  require 'open-uri'
  require 'nokogiri'
  require 'rest-client'
  require 'mechanize'
  
  before_action :set_rrc, only: [:show, :edit, :update, :destroy]
  before_action :authorize,  except: [:advt]
	
  def authorize
    if current_user.nil?
      redirect_to login_url, alert: "Not authorized! Please log in."
     end
  end

  # GET /rrcs
  def index
    @search = Rrc.ransack(params[:q]) #используется gem ransack для поиска и сортировки
    @search.sorts = 'title asc' if @search.sorts.empty? # сортировка таблицы по алфавиту по умолчанию 
    @rrcs = @search.result.paginate(page: params[:page], per_page: 50)
    @totalrrcs = Rrc.where("id = #{:id}").count
    respond_to do |format|
      format.html
      format.csv { send_data @rrcs.to_csv }
      format.xls # { ssend_data @homyproducts.to_csv(col_sep: "\t") }
    end
  end

  # GET /rrcs/1
  def show
  end

  # GET /rrcs/new
  def new
    @rrc = Rrc.new
  end

  # GET /rrcs/1/edit
  def edit
  end

  # POST /rrcs
  def create
    @rrc = Rrc.new(rrc_params)

    if @rrc.save
      redirect_to @rrc, notice: 'Rrc was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /rrcs/1
  def update
    if @rrc.update(rrc_params)
      redirect_to @rrc, notice: 'Rrc was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /rrcs/1
  def destroy
    @rrc.destroy
    redirect_to rrcs_url, notice: 'Rrc was successfully destroyed.'
  end
  
  def import
    Rrc.import(params[:file])
    redirect_to rrcs_url, notice: "Products imported."
  end
  
  def downloadproduct
  	system ('rake rrcdownload')
#   @rrc = Rrc.downloadproduct
    flash[:notice] = 'Products was successfully downloaded'
    redirect_to rrcs_path	
  end
  
  def updateproduct
    @rrc = Rrc.updateproduct
    flash[:notice] = 'Products was successfully updated'
    redirect_to rrcs_path 
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_rrc
      @rrc = Rrc.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def rrc_params
      params.require(:rrc).permit(:sku, :title, :quantity, :cost_price, :price, :sell_price)
    end
end
