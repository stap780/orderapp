class EnergiesController < ApplicationController
  before_action :set_energy, only: [:show, :edit, :update, :destroy]

  # GET /energies
  def index
    @energies = Energy.all
    @search = Energy.ransack(params[:q])
    @search.sorts = 'title asc' if @search.sorts.empty?
    @energies = @search.result
    @totalenergies = Energy.count
    respond_to do |format|
      format.html
      format.csv { send_data @energies.to_csv }
      format.xls # { ssend_data @energies.to_csv(col_sep: "\t") }
    end
  end

  # GET /energies/1
  def show
  end

  # GET /energies/new
  def new
    @energy = Energy.new
  end

  # GET /energies/1/edit
  def edit
  end

  # POST /energies
  def create
    @energy = Energy.new(energy_params)

    if @energy.save
      redirect_to @energy, notice: 'Energy was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /energies/1
  def update
    if @energy.update(energy_params)
      redirect_to @energy, notice: 'Energy was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /energies/1
  def destroy
    @energy.destroy
    redirect_to energies_url, notice: 'Energy was successfully destroyed.'
  end

  def import
    Energy.import(params[:file])
    redirect_to energies_url, notice: "Products imported."
  end
  
  def updateproduct
    @energy = Energy.updateproduct
    flash[:notice] = 'Products was successfully updated'
    redirect_to energies_path 
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_energy
      @energy = Energy.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def energy_params
      params.require(:energy).permit(:sku, :title, :quantity, :cost_price, :price)
    end
end
