class DoversController < ApplicationController
  
  before_action :set_dover, only: [:show, :edit, :update, :print, :destroy]
  before_action :authorize
  autocomplete :product, :title, full: true,  :extra_data => [:id]
  autocomplete :company, :title, full: true,  :extra_data => [:inn], :case_sensitive => true

	def authorize
		if current_user.nil?
		redirect_to login_url, alert: "Not authorized! Please log in."
		end
	end

  # GET /dovers
  # GET /dovers.json
  def index
    @search = Dover.ransack(params[:q]) #используется gem ransack для поиска и сортировки
    @search.sorts = 'number desc' if @search.sorts.empty? # сортировка таблицы по номеру по умолчанию 
    @dovers = @search.result.paginate(page: params[:page], per_page: 30) 

  end

  # GET /dovers/1
  # GET /dovers/1.json
  def show
  end

  # GET /dovers/new
  def new
    @dover = Dover.new
  end

  # GET /dovers/1/edit
  def edit
      @dover = Dover.find(params[:id])
  end

  # POST /dovers
  # POST /dovers.json
  def create
    @dover = Dover.new(dover_params)

    respond_to do |format|
      if @dover.save
	      
        format.html { redirect_to @dover, notice: 'Dover was successfully created.' }
        format.json { render :show, status: :created, location: @dover }
      else
        format.html { render :new }
        format.json { render json: @dover.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /dovers/1
  # PATCH/PUT /dovers/1.json
  def update
    respond_to do |format|
			if @dover.update(dover_params)	      
        format.html { redirect_to @dover, notice: 'Dover was successfully updated.' }
        format.json { render :show, status: :ok, location: @dover }
      else
        format.html { render :edit }
        format.json { render json: @dover.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /dovers/1
  # DELETE /dovers/1.json
  def destroy
    @dover.destroy
    respond_to do |format|
      format.html { redirect_to dovers_url, notice: 'Dover was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
  
  def print
    render :pdf => "Доверенность #{@dover.number}",
           :template => "dovers/print"
	end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_dover
      @dover = Dover.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def dover_params
      params.require(:dover).permit(:number, :startdate, :enddate, :company_id, :user_id, :subj,:dover_items_attributes =>[:id, :product_id, :quantity, :dover_id, :_destroy])
    end
end
