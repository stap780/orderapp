class VariantsController < ApplicationController
  before_action :set_variant, only: [:show, :edit, :update, :destroy]

  # GET /variants
  # GET /variants.json
  def index
    @variants = Variant.order(:product_id)
    @var= Variant.where("product_option_id IS NOT NULL").count
    respond_to do |format|
      format.html
      format.csv do
      headers['Content-Disposition'] = "attachment; filename=\"variants.csv\""
      headers['Content-Type'] ||= 'text/csv'
      end
      format.xls # { send_data @products_all.to_csv(col_sep: "\t") }
    end        
  end

  # GET /variants/1
  # GET /variants/1.json
  def show
  end

  # GET /variants/new
  def new
    @variant = Variant.new
  end

  # GET /variants/1/edit
  def edit
  end

  # POST /variants
  # POST /variants.json
  def create
    @variant = Variant.new(variant_params)

    respond_to do |format|
      if @variant.save
        format.html { redirect_to @variant, notice: 'Variant was successfully created.' }
        format.json { render :show, status: :created, location: @variant }
      else
        format.html { render :new }
        format.json { render json: @variant.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /variants/1
  # PATCH/PUT /variants/1.json
  def update
    respond_to do |format|
      if @variant.update(variant_params)
        format.html { redirect_to @variant, notice: 'Variant was successfully updated.' }
        format.json { render :show, status: :ok, location: @variant }
      else
        format.html { render :edit }
        format.json { render json: @variant.errors, status: :unprocessable_entity }
      end
    end
  end
  
  def addvariant 
    @variant = Variant.addvariant
    flash[:notice] = 'Variants was successfully added'
    redirect_to variants_path
  end
  
  def updateqt
  	@variant = Variant.updateqt
    flash[:notice] = 'Quantity was successfully updated'
    redirect_to variants_path
  end

  # DELETE /variants/1
  # DELETE /variants/1.json
  def destroy
    @variant.destroy
    respond_to do |format|
      format.html { redirect_to variants_url, notice: 'Variant was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_variant
      @variant = Variant.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def variant_params
      params.require(:variant).permit(:product_id, :variant_inid, :sku, :cost_price, :price, :old_price, :quantity, :weight, :product_option_id, :supplier_id)
    end
end
