class CitilinksController < ApplicationController
  before_action :set_citilink, only: [:show, :edit, :update, :destroy]

  # GET /citilinks
  def index
    @citilinks = Citilink.all
  end

  # GET /citilinks/1
  def show
  end

  # GET /citilinks/new
  def new
    @citilink = Citilink.new
  end

  # GET /citilinks/1/edit
  def edit
  end

  # POST /citilinks
  def create
    @citilink = Citilink.new(citilink_params)

    if @citilink.save
      redirect_to @citilink, notice: 'Citilink was successfully created.'
    else
      render :new
    end
  end
  
  def downloadproduct 
    @citilink = Citilink.downloadproduct
    flash[:notice] = 'Products was successfully downloaded'
    redirect_to citilinks_path
  end
  
  def updateproduct
    @citilink = Citilink.updateproduct
    flash[:notice] = 'Products was successfully updated'
    redirect_to citilinks_path
  end


  # PATCH/PUT /citilinks/1
  def update
    if @citilink.update(citilink_params)
      redirect_to @citilink, notice: 'Citilink was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /citilinks/1
  def destroy
    @citilink.destroy
    redirect_to citilinks_url, notice: 'Citilink was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_citilink
      @citilink = Citilink.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def citilink_params
      params.require(:citilink).permit(:title, :price, :price1, :priceusd, :q1, :q2, :q3, :q4, :q5, :quantity)
    end
end
