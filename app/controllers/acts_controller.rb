class ActsController < ApplicationController
  before_action :set_act, only: [:show, :edit, :update, :print, :destroy]
  before_action :authorize
  autocomplete :company, :title, full: true,  :extra_data => [:inn], :case_sensitive => true

	def authorize
		if current_user.nil?
		redirect_to login_url, alert: "Not authorized! Please log in."
		end
	end

  # GET /acts
  # GET /acts.json
  def index
    @acts = Act.all
  end

  # GET /acts/1
  # GET /acts/1.json
  def show
  end

  # GET /acts/new
  def new
    @act = Act.new
  end

  # GET /acts/1/edit
  def edit
  end

  # POST /acts
  # POST /acts.json
  def create
    @act = Act.new(act_params)

    respond_to do |format|
      if @act.save
        format.html { redirect_to @act, notice: 'Act was successfully created.' }
        format.json { render :show, status: :created, location: @act }
      else
        format.html { render :new }
        format.json { render json: @act.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /acts/1
  # PATCH/PUT /acts/1.json
  def update
    respond_to do |format|
      if @act.update(act_params)
        format.html { redirect_to @act, notice: 'Act was successfully updated.' }
        format.json { render :show, status: :ok, location: @act }
      else
        format.html { render :edit }
        format.json { render json: @act.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /acts/1
  # DELETE /acts/1.json
  def destroy
    @act.destroy
    respond_to do |format|
      format.html { redirect_to acts_url, notice: 'Act was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
  
	def print
		#comp.invoices.first.banks.first
		@comp = Company.find(@act.company.id)
		@bank = Bank.where(:payer_id => @act.company_id).where("date >= ? AND date <= ?", @act.startdate, @act.enddate)
		@inv = Invoice.where(:company_id => @act.company_id).where("date >= ? AND date <= ?", @act.startdate, @act.enddate)
	render :pdf => "Акт сверки #{@act.id}",
	       :template => "acts/print"
	end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_act
      @act = Act.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def act_params
      params.require(:act).permit(:company_id, :startdate, :enddate)
    end
end
