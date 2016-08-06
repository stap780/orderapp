class DpdsController < ApplicationController
  before_action :set_dpd, only: [:show, :edit, :update, :destroy]

  # GET /dpds
  def index
    
     @search = Dpd.ransack(params[:q]) #используется gem ransack для поиска и сортировки
     @search.sorts = 'numer desc' if @search.sorts.empty? # сортировка таблицы по номеру по умолчанию 
     @dpds = @search.result.paginate(page: params[:page], per_page: 30)

  end

  # GET /dpds/1
  def show
  end

  # GET /dpds/new
  def new
    @dpd = Dpd.new
  end

  # GET /dpds/1/edit
  def edit
  end

  # POST /dpds
  def create
    @dpd = Dpd.new(dpd_params)

    if @dpd.save
      redirect_to @dpd, notice: 'Dpd was successfully created.'
    else
      render :new
    end
  end
  
  def updatedpd
    @dpd = Dpd.updatedpd
    flash[:notice] = 'Dpd was successfully updated'
    redirect_to dpds_path
  end

  # PATCH/PUT /dpds/1
  def update
    if @dpd.update(dpd_params)
      redirect_to @dpd, notice: 'Dpd was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /dpds/1
  def destroy
    @dpd.destroy
    redirect_to dpds_url, notice: 'Dpd was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_dpd
      @dpd = Dpd.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def dpd_params
      params.require(:dpd).permit(:numer, :dpdnumber, :pickupdate, :plandeliverytime, :state)
    end
end
