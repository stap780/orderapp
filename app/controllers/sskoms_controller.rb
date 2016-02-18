class SskomsController < ApplicationController
  before_action :set_sskom, only: [:show, :edit, :update, :destroy]

  # GET /sskoms
  def index
    @search = Sskom.ransack(params[:q])
    @search.sorts = 'title asc' if @search.sorts.empty?
    @sskoms = @search.result
    @totalsskoms = Sskom.count
    respond_to do |format|
      format.html
      format.csv { send_data @vimcoms.to_csv }
      format.xls # { ssend_data @vimcoms.to_csv(col_sep: "\t") }
    end
  end

  # GET /sskoms/1
  def show
  end

  # GET /sskoms/new
  def new
    @sskom = Sskom.new
  end

  # GET /sskoms/1/edit
  def edit
  end

  # POST /sskoms
  def create
    @sskom = Sskom.new(sskom_params)

    if @sskom.save
      redirect_to @sskom, notice: 'Sskom was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /sskoms/1
  def update
    if @sskom.update(sskom_params)
      redirect_to @sskom, notice: 'Sskom was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /sskoms/1
  def destroy
    @sskom.destroy
    redirect_to sskoms_url, notice: 'Sskom was successfully destroyed.'
  end
  
  def import
    Sskom.import(params[:file])
    redirect_to sskoms_url, notice: "Products imported."
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_sskom
      @sskom = Sskom.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def sskom_params
      params.require(:sskom).permit(:title, :quantity)
    end
end
