class VendorsController < ApplicationController
  before_action :set_vendor, only: [:show, :edit, :update, :destroy]

  # GET /vendors
  def index
    @vendors = Vendor.all
    @totalipmatikas = Ipmatika.count
    @ipmatikasynchro = Product.where("ipmatika_id is not null").count
    @totalvimcoms = Vimcom.count
    @vimcomsynchro = Product.where("vimcom_id is not null").count
    @totalhomyproducts = Homyproduct.count
    @homyproductsynchro = Product.where("homyproduct_id is not null").count
    @totalemags = Emag.count
    @emagsynchro = Product.where("emag_id is not null").count
    @totalrrcs = Rrc.count
    @rrcsynchro = Product.where("rrc_id is not null").count
    @totalangels = Angel.count
    @angelsynchro = Product.where("angel_id is not null").count
    @totalsskoms = Sskom.count
    @sskomsynchro = Product.where("sskom_id is not null").count
    
  end

  # GET /vendors/1
  def show
  end

  # GET /vendors/new
  def new
    @vendor = Vendor.new
  end

  # GET /vendors/1/edit
  def edit
  end

  # POST /vendors
  def create
    @vendor = Vendor.new(vendor_params)

    if @vendor.save
      redirect_to @vendor, notice: 'Vendor was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /vendors/1
  def update
    if @vendor.update(vendor_params)
      redirect_to @vendor, notice: 'Vendor was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /vendors/1
  def destroy
    @vendor.destroy
    redirect_to vendors_url, notice: 'Vendor was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_vendor
      @vendor = Vendor.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def vendor_params
      params.require(:vendor).permit(:title)
    end
end
