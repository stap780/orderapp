#-*- encoding : utf-8 -*-
class CompaniesController < ApplicationController
  before_action :set_company, only: [:show, :edit, :update, :destroy]
  before_action :authorize
	
  def authorize
    if current_user.nil?
      redirect_to login_url, alert: "Not authorized! Please log in."
     end
  end

  # GET /companies
  def index
    @search = Company.ransack(params[:q])
     @search.sorts = 'title desc' if @search.sorts.empty? 
     @companies = @search.result.paginate(page: params[:page], per_page: 30)
			respond_to do |format|
			format.html
			format.json 
			end  
  end

  # GET /companies/1
  def show
	  respond_to do |format|
      format.html
      format.js
      format.json
    end
  end

  # GET /companies/new
  def new
    @company = Company.new
  end

  # GET /companies/1/edit
  def edit
  @company = Company.find(params[:id])
  end

  # POST /companies
  def create
    @company = Company.new(company_params)

    if @company.save
      redirect_to @company, notice: 'Company was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /companies/1
  def update
    if @company.update(company_params)
      redirect_to @company, notice: 'Company was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /companies/1
  def destroy
    @company.destroy
    redirect_to companies_url, notice: 'Company was successfully destroyed.'
  end
  
  def getcompany 
    @companies = Company.where("title LIKE ?", "%#{params[:title]}%")
    #@companies = Company.all	
			respond_to do |format|
			format.json 
			end 
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_company
      @company = Company.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def company_params
      params.require(:company).permit(:title, :fulltitle, :uraddress, :factaddress, :inn, :kpp, :ogrn, :okpo, :bik, :banktitle, :bankaccount, :client_ids)
    end
end
