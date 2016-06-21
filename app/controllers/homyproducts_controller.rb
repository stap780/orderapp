class HomyproductsController < ApplicationController

require 'roo'
  before_action :set_homyproduct, only: [:show, :edit, :update, :destroy]

  # GET /homyproducts
  def index
    @search = Homyproduct.ransack(params[:q]) #используется gem ransack для поиска и сортировки
    @search.sorts = 'id asc' if @search.sorts.empty? # сортировка таблицы по алфавиту по умолчанию 
    @homyproducts = @search.result
    @totalproducts = Homyproduct.count
    @homynotzero = Homyproduct.where("quantity_all_free > 0").count
    respond_to do |format|
      format.html
      format.csv { send_data @homyproducts.to_csv }
      format.xls # { ssend_data @homyproducts.to_csv(col_sep: "\t") }
    end    
  end

  # GET /homyproducts/1
  def show
  end

  # GET /homyproducts/new
  def new
    @homyproduct = Homyproduct.new
  end

  # GET /homyproducts/1/edit
  def edit
  end

  # POST /homyproducts
  def create
    @homyproduct = Homyproduct.new(homyproduct_params)

    if @homyproduct.save
      redirect_to @homyproduct, notice: 'Homyproduct was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /homyproducts/1
  def update
    if @homyproduct.update(homyproduct_params)
      
      redirect_to @homyproduct, notice: 'Homyproduct was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /homyproducts/1
  def destroy
    @homyproduct.destroy
    redirect_to homyproducts_url, notice: 'Homyproduct was successfully destroyed.'
  end
  
  def import
    Homyproduct.import(params[:file])
    redirect_to homyproducts_url, notice: "Products imported."
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_homyproduct
      @homyproduct = Homyproduct.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def homyproduct_params
      params.require(:homyproduct).permit(:artikul, :sku, :title, :price, :valuta, :quantity_all_res, :quantity_all_free, :quantity_main_res, :quantity_main_free, :quantity_tul_res, :quantity_tul_free, :quantity_transit_all, :quantity_transit_free, :id, :sell_price, :min_price)
    end
end
