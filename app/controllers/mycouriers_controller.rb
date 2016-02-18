class MycouriersController < ApplicationController
  before_action :set_mycourier, only: [:show, :edit, :update, :destroy]

  # GET /mycouriers
  def index
    @mycouriers = Mycourier.all
  end

  # GET /mycouriers/1
  def show
  end

  # GET /mycouriers/new
  def new
    @mycourier = Mycourier.new
  end

  # GET /mycouriers/1/edit
  def edit
  end

  # POST /mycouriers
  def create
    @mycourier = Mycourier.new(mycourier_params)

    if @mycourier.save
      redirect_to @mycourier, notice: 'Mycourier was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /mycouriers/1
  def update
    if @mycourier.update(mycourier_params)
      redirect_to @mycourier, notice: 'Mycourier was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /mycouriers/1
  def destroy
    @mycourier.destroy
    redirect_to mycouriers_url, notice: 'Mycourier was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_mycourier
      @mycourier = Mycourier.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def mycourier_params
      params.require(:mycourier).permit(:title, :number)
    end
end
