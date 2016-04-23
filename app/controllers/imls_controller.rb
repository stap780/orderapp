class ImlsController < ApplicationController
  before_action :set_iml, only: [:show, :edit, :update, :destroy]

  # GET /imls
  def index
     @search = Iml.ransack(params[:q]) #используется gem ransack для поиска и сортировки
     @search.sorts = 'number desc' if @search.sorts.empty? # сортировка таблицы по номеру по умолчанию 
     @imls = @search.result.paginate(page: params[:page], per_page: 30) 
  end

  # GET /imls/1
  def show
  end
  
  def json_work
  @imls = Iml.all
  imls = @imls.to_json
  render :json => imls, :callback => params[:callback]
  
  end

  # GET /imls/new
  def new
    @iml = Iml.new
  end

  # GET /imls/1/edit
  def edit
  end

  # POST /imls
  def create
    @iml = Iml.new(iml_params)

    if @iml.save
      redirect_to @iml, notice: 'Iml was successfully created.'
    else
      render :new
    end
  end
  
  def updateiml
    @iml = Iml.updateiml
    flash[:notice] = 'Imls was successfully updated'
    redirect_to imls_path
  end

  # PATCH/PUT /imls/1
  def update
    if @iml.update(iml_params)
      redirect_to @iml, notice: 'Iml was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /imls/1
  def destroy
    @iml.destroy
    redirect_to imls_url, notice: 'Iml was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_iml
      @iml = Iml.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def iml_params
      params.require(:iml).permit(:number, :state, :status, :statusdate, :barcode, :statenum, :statusnum)
    end
end
