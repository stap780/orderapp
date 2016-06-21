class GstelesController < ApplicationController

require 'roo'

  before_action :set_gstele, only: [:show, :edit, :update, :destroy]

  # GET /gsteles
  # GET /gsteles.json
  def index
    @search = Gstele.ransack(params[:q]) #используется gem ransack для поиска и сортировки
    @search.sorts = 'title asc' if @search.sorts.empty? # сортировка таблицы по алфавиту по умолчанию 
    @gsteles = @search.result
    respond_to do |format|
      format.html
      format.csv { send_data @gsteles.to_csv }
      format.xls # { ssend_data @homyproducts.to_csv(col_sep: "\t") }
    end    
  end

  # GET /gsteles/1
  # GET /gsteles/1.json
  def show
  end

  # GET /gsteles/new
  def new
    @gstele = Gstele.new
  end

  # GET /gsteles/1/edit
  def edit
  end

  # POST /gsteles
  # POST /gsteles.json
  def create
    @gstele = Gstele.new(gstele_params)

    respond_to do |format|
      if @gstele.save
        format.html { redirect_to @gstele, notice: 'Gstele was successfully created.' }
        format.json { render :show, status: :created, location: @gstele }
      else
        format.html { render :new }
        format.json { render json: @gstele.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /gsteles/1
  # PATCH/PUT /gsteles/1.json
  def update
    respond_to do |format|
      if @gstele.update(gstele_params)
        format.html { redirect_to @gstele, notice: 'Gstele was successfully updated.' }
        format.json { render :show, status: :ok, location: @gstele }
      else
        format.html { render :edit }
        format.json { render json: @gstele.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /gsteles/1
  # DELETE /gsteles/1.json
  def destroy
    @gstele.destroy
    respond_to do |format|
      format.html { redirect_to gsteles_url, notice: 'Gstele was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
  
  def import
    Gstele.import(params[:file])
    redirect_to gsteles_url, notice: "Products imported."
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_gstele
      @gstele = Gstele.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def gstele_params
      params.require(:gstele).permit(:sku, :title, :quantity, :valute, :cost_price, :price)
    end
end
