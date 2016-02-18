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
    @emags = @search.result
    @totalemags = Emag.count
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
    redirect_to emags_url, notice: 'Emag was successfully destroyed.'
  end
  
   def downloadproduct
    system ('rake emagdownload')
    flash[:notice] = 'Products was successfully downloaded'
    redirect_to emags_path	
  end
  
  def updateproduct
    @emag = Emag.updateproduct
    flash[:notice] = 'Products was successfully updated'
    redirect_to emags_path 
  end
  

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_emag
      @emag = Emag.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def emag_params
      params[:emag].permit(:sku, :title, :quantity)
    end
end
