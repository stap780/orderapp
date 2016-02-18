# -*- encoding : utf-8 -*-
class OrderstatusesController < ApplicationController
  before_action :set_orderstatus, only: [:show, :edit, :update, :destroy]

  # GET /orderstatuses
  def index
    @orderstatuses = Orderstatus.all.order(:number)
  end

  # GET /orderstatuses/1
  def show
  end

  # GET /orderstatuses/new
  def new
    @orderstatus = Orderstatus.new
    
  end

  # GET /orderstatuses/1/edit
  def edit
  end

  # POST /orderstatuses
  def create
    @orderstatus = Orderstatus.new(orderstatus_params)

    if @orderstatus.save
      redirect_to @orderstatus, notice: 'Orderstatus was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /orderstatuses/1
  def update
    if @orderstatus.update(orderstatus_params)
      redirect_to @orderstatus, notice: 'Orderstatus was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /orderstatuses/1
  def destroy
    @orderstatus.destroy
    redirect_to orderstatuses_url, notice: 'Orderstatus was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_orderstatus
      @orderstatus = Orderstatus.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def orderstatus_params
      params.require(:orderstatus).permit(:id, :order_id ,:title, :instatus, :iorder_id, :number)
    end
end
