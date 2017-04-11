class CasesController < ApplicationController
  
  skip_before_filter :verify_authenticity_token
  before_action :set_case, only: [:show, :edit, :update, :destroy]
  before_action :authorize,  except: [:create_json_case]
	autocomplete :client, :name, full: true, :display_value => :client_name_surname,  :extra_data => [:name, :middlename, :surname, :phone, :email, :zip, :city, :address]
  
  def authorize
    if current_user.nil?
      redirect_to login_url, alert: "Not authorized! Please log in."
     end
  end
  
  # GET /cases
  # GET /cases.json
  def index
    
		@search = Case.ransack(params[:q]) #используется gem ransack для поиска и сортировки
		@search.sorts = 'id desc' if @search.sorts.empty? # сортировка таблицы по номеру по умолчанию 
		@cases = @search.result.paginate(page: params[:page], per_page: 30)
			respond_to do |format|
			format.html
			format.json
			end

  end

  # GET /cases/1
  # GET /cases/1.json
  def show
  end

  # GET /cases/new
  def new
    @case = Case.new
  end

  # GET /cases/1/edit
  def edit
  end

  # POST /cases
  # POST /cases.json
  def create
    @case = Case.new(case_params)

    respond_to do |format|
      if @case.save
        format.html { redirect_to @case, notice: 'Case was successfully created.' }
        format.json { render :show, status: :created, location: @case }
      else
        format.html { render :new }
        format.json { render json: @case.errors, status: :unprocessable_entity }
      end
    end
  end
  
  def create_json_case
	  headers['Access-Control-Allow-Methods'] = 'POST, GET, OPTIONS'
    #headers['Access-Control-Allow-Headers'] = 'x-requested-with'
    headers['Access-Control-Allow-Origin'] = 'http://ketago.com'
    if request.post?
	   @case = Case.new
  		
  	client = Client.find_by_phone(params[:phone])
  	if client.present?
		@case.client_id = client.id
		client.email = params[:email]
		client.save
		else
		client = Client.new(name: params[:name], surname: params[:surname], phone: params[:phone], email: params[:email])
		client.save
		client = Client.find_by_phone(params[:phone])
		@case.client_id = client.id
		end
		@case.service = params[:product]
		@case.description = params[:description]+" "+"("+params[:name]+" "+params[:surname]+" "+params[:phone]+")"
		
		end
		respond_to do |format|
			if @case.save
			format.json  { render :json => @case}
			else
			format.json { render  :json => @case }
			end
		end
		
	@case = Case.last
	if @case.nil?
	id = 0
	@case.number = 	(Date.today.day.to_s+"#{id}".to_s).gsub('-','').to_i
	else
	@case.number = 	(Date.today.day.to_s+"#{@case.id}".to_s).gsub('-','').to_i
	@case.save
	end
	
	CaseMailer.new_case(@case).deliver_now
	CaseMailer.notifier_case(@case).deliver_now
	
  end
  
  
  # PATCH/PUT /cases/1
  # PATCH/PUT /cases/1.json
  def update
    respond_to do |format|
      if @case.update(case_params)
        format.html { redirect_to @case, notice: 'Case was successfully updated.' }
        format.json { render :show, status: :ok, location: @case }
      else
        format.html { render :edit }
        format.json { render json: @case.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /cases/1
  # DELETE /cases/1.json
  def destroy
    @case.destroy
    respond_to do |format|
      format.html { redirect_to cases_url, notice: 'Case was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_case
      @case = Case.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def case_params
      params.require(:case).permit(:number, :client_id, :iorder_id, :status, :service, :description, :iorder_check)
    end
end
