class CouriersController < ApplicationController
  before_action :set_courier, only: [:show, :edit, :update, :destroy]

  # GET /couriers
  def index
    @couriers = Courier.all
  end

  # GET /couriers/1
  def show
  end

  # GET /couriers/new
  def new
    @courier = Courier.new
  end

  # GET /couriers/1/edit
  def edit
  end

  # POST /couriers
  def create
    @courier = Courier.new(courier_params)

    if @courier.save
      redirect_to @courier, notice: 'Courier was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /couriers/1
  def update
    if @courier.update(courier_params)
      redirect_to @courier, notice: 'Courier was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /couriers/1
  def destroy
    @courier.destroy
    redirect_to couriers_url, notice: 'Courier was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_courier
      @courier = Courier.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def courier_params
      params.require(:courier).permit(:number, :date, :state)
    end
end
