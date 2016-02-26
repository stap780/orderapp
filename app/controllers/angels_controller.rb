class AngelsController < ApplicationController
  before_action :set_angel, only: [:show, :edit, :update, :destroy]
  before_action :authorize
	
  def authorize
    if current_user.nil?
      redirect_to login_url, alert: "Not authorized! Please log in."
     end
  end

  # GET /angels
  def index
    @search = Angel.ransack(params[:q]) #используется gem ransack для поиска и сортировки
    @search.sorts = 'title asc' if @search.sorts.empty? # сортировка таблицы по алфавиту по умолчанию 
    @angels = @search.result
    @totalproducts = Angel.count
    respond_to do |format|
      format.html
      format.csv { send_data @angels.to_csv }
      format.xls # { ssend_data @angels.to_csv(col_sep: "\t") }
    end
  end

  # GET /angels/1
  def show
  end

  # GET /angels/new
  def new
    @angel = Angel.new
  end

  # GET /angels/1/edit
  def edit
  end

  # POST /angels
  def create
    @angel = Angel.new(angel_params)

    if @angel.save
      redirect_to @angel, notice: 'Angel was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /angels/1
  def update
    if @angel.update(angel_params)
      redirect_to @angel, notice: 'Angel was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /angels/1
  def destroy
    @angel.destroy
    redirect_to angels_url, notice: 'Angel was successfully destroyed.'
  end
  
  def import
    Angel.import(params[:file])
    redirect_to angels_url, notice: "Products imported."
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_angel
      @angel = Angel.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def angel_params
      params.require(:angel).permit(:sku, :title, :quantity, :status, :valuta, :price, :cost_price)
    end
end
