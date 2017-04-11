class VozvratsController < ApplicationController
  before_action :set_vozvrat, only: [:show, :edit, :update, :destroy]

  # GET /vozvrats
  # GET /vozvrats.json
  def index
    @vozvrats = Vozvrat.all
  end

  # GET /vozvrats/1
  # GET /vozvrats/1.json
  def show
  end

  # GET /vozvrats/new
  def new
    @vozvrat = Vozvrat.new
  end

  # GET /vozvrats/1/edit
  def edit
  end

  # POST /vozvrats
  # POST /vozvrats.json
  def create
    @vozvrat = Vozvrat.new(vozvrat_params)

    respond_to do |format|
      if @vozvrat.save
        format.html { redirect_to @vozvrat, notice: 'Vozvrat was successfully created.' }
        format.json { render :show, status: :created, location: @vozvrat }
      else
        format.html { render :new }
        format.json { render json: @vozvrat.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /vozvrats/1
  # PATCH/PUT /vozvrats/1.json
  def update
    respond_to do |format|
      if @vozvrat.update(vozvrat_params)
        format.html { redirect_to @vozvrat, notice: 'Vozvrat was successfully updated.' }
        format.json { render :show, status: :ok, location: @vozvrat }
      else
        format.html { render :edit }
        format.json { render json: @vozvrat.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /vozvrats/1
  # DELETE /vozvrats/1.json
  def destroy
    @vozvrat.destroy
    respond_to do |format|
      format.html { redirect_to vozvrats_url, notice: 'Vozvrat was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_vozvrat
      @vozvrat = Vozvrat.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def vozvrat_params
      params.require(:vozvrat).permit(:number, :date, :invoice_list_id)
    end
end
