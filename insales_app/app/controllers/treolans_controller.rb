class TreolansController < ApplicationController
  before_action :set_treolan, only: [:show, :edit, :update, :destroy]

  # GET /treolans
  def index
    @treolans = Treolan.all
  end

  # GET /treolans/1
  def show
  end

  # GET /treolans/new
  def new
    @treolan = Treolan.new
  end

  # GET /treolans/1/edit
  def edit
  end

  # POST /treolans
  def create
    @treolan = Treolan.new(treolan_params)

    if @treolan.save
      redirect_to @treolan, notice: 'Treolan was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /treolans/1
  def update
    if @treolan.update(treolan_params)
      redirect_to @treolan, notice: 'Treolan was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /treolans/1
  def destroy
    @treolan.destroy
    redirect_to treolans_url, notice: 'Treolan was successfully destroyed.'
  end
  
  def import
    Treolan.import(params[:file])
    redirect_to treolans_url, notice: "Products imported."
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_treolan
      @treolan = Treolan.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def treolan_params
      params.require(:treolan).permit(:sku, :title, :quantity, :transit, :price)
    end
end
