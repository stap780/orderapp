class EmagsController < ApplicationController
  
  require 'open-uri'
  require 'nokogiri'
  require 'rest-client'
  require 'mechanize'
  
  
  before_action :set_emag, only: [:show, :edit, :update, :destroy]

  # GET /emags
  def index
    @search = Emag.ransack(params[:q])
    @search.sorts = 'title asc' if @search.sorts.empty?
    @emags = @search.result.includes(:products).paginate(page: params[:page], per_page: 50)
    @totalemags = Emag.count
    @emag_not_nill = Emag.where("quantity > 0").count
    @emag_synchro = Product.where("emag_id IS NOT NULL").count
    respond_to do |format|
      format.html
      format.csv { send_data @emags.to_csv }
      format.xls # { ssend_data @emags.to_csv(col_sep: "\t") }
    end
      
  end

  # GET /emags/1
  def show
  end

  # GET /emags/new
  def new
    @emag = Emag.new
  end

  # GET /emags/1/edit
  def edit
  end

  # POST /emags
  def create
    @emag = Emag.new(emag_params)

    if @emag.save
      redirect_to @emag, notice: 'Emag was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /emags/1
  def update
    if @emag.update(emag_params)
      redirect_to @emag, notice: 'Emag was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /emags/1
  def destroy
    @emag.destroy
    flash[:notice] = 'Emag was successfully destroyed.'
    redirect_to emags_url
  end
  
   def downloadproduct
    system ('rake emagdownload')
    flash[:notice] = 'Products was successfully uploaded'
    redirect_to emags_path	
  end
  
  def updateproduct
    @emag = Emag.updateproduct
    flash[:notice] = 'Products was successfully updated'
    redirect_to emags_path 
  end
  
  def import
    Emag.import(params[:file])
    flash[:notice] = "Products imported."
    redirect_to emags_url
  end
  

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_emag
      @emag = Emag.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def emag_params
      params[:emag].permit(:sku, :title, :quantity, :price, :cost_price, :discount)
    end
end
