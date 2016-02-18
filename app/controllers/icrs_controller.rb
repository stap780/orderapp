class IcrsController < ApplicationController
  before_action :set_icr, only: [:show, :edit, :update, :destroy]

  # GET /icrs
  def index
    @icrs = Icr.all
    @totalproducts = Icr.count
  end

  # GET /icrs/1
  def show
  end

  # GET /icrs/new
  def new
    @icr = Icr.new
  end

  # GET /icrs/1/edit
  def edit
  end

  # POST /icrs
  def create
    @icr = Icr.new(icr_params)

    if @icr.save
      redirect_to @icr, notice: 'Icr was successfully created.'
    else
      render :new
    end
  end
  
  def downloadproduct 
    @icr = Icr.downloadproduct
    flash[:notice] = 'Products was successfully downloaded'
    redirect_to icrs_path
  end
  
  def updateproduct
    @icr = Icr.updateproduct
    flash[:notice] = 'Products was successfully updated'
    redirect_to icrs_path
  end

  # PATCH/PUT /icrs/1
  def update
    if @icr.update(icr_params)
      redirect_to @icr, notice: 'Icr was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /icrs/1
  def destroy
    @icr.destroy
    redirect_to icrs_url, notice: 'Icr was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_icr
      @icr = Icr.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def icr_params
      params.require(:icr).permit(:icr_id, :title, :price_usd, :price_rub)
    end
end
