class VimcomsController < ApplicationController
  before_action :set_vimcom, only: [:show, :edit, :update, :destroy]

  # GET /vimcoms
  def index
    
    @search = Vimcom.ransack(params[:q])
    @search.sorts = 'title asc' if @search.sorts.empty?
    @vimcoms = @search.result
    @totalvimcoms = Vimcom.count
    respond_to do |format|
      format.html
      format.csv { send_data @vimcoms.to_csv }
      format.xls # { ssend_data @vimcoms.to_csv(col_sep: "\t") }
    end

  end

  # GET /vimcoms/1
  def show
  end

  # GET /vimcoms/new
  def new
    @vimcom = Vimcom.new
  end

  # GET /vimcoms/1/edit
  def edit
  end

  # POST /vimcoms
  def create
    @vimcom = Vimcom.new(vimcom_params)

    if @vimcom.save
      redirect_to @vimcom, notice: 'Vimcom was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /vimcoms/1
  def update
    if @vimcom.update(vimcom_params)
      redirect_to @vimcom, notice: 'Vimcom was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /vimcoms/1
  def destroy
    @vimcom.destroy
    redirect_to vimcoms_url, notice: 'Vimcom was successfully destroyed.'
  end
  
  def import
    Vimcom.import(params[:file])
    redirect_to vimcoms_url, notice: "Products imported."
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_vimcom
      @vimcom = Vimcom.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def vimcom_params
      params.require(:vimcom).permit(:title, :quantity_all, :quantity_free)
    end
end
