# -*- encoding : utf-8 -*-
class OrdersController < ApplicationController
    require 'open-uri'
    require 'nokogiri'
    require 'rest-client'
  
  before_action :set_order, only: [:show, :edit, :update, :destroy]


  # GET /orders
  def index
    @orders = Order.all
  
    url = "http://worksys.myinsales.ru/admin/orders.xml"
    data = Nokogiri::XML(open(url, :http_basic_authentication => ['a75a0364d3cdd9f4de05bc69a5d17084' ,'15ec04dba5b5045675b8b3a80dcb1486']))
    
    order = "orders/order"
    @iorders = data.xpath(order)
    
    
    #iorders.each do |iorder|
    #  iorder_number = iorder.xpath("number").text
    #  iorder_status = iorder.xpath("fulfillment-status").text
    #  iorder_finstatus = iorder.xpath("financial-status").text ]
    #puts "#{iorder_number}, #{iorder_status}, #{iorder_finstatus}"  # выводит списком в строку с указанием переменных
    #end  
    
    #p [iorder.xpath("number").text , 
    #   iorder.xpath("fulfillment-status").text ,
    #   iorder.xpath("financial-status").text ]                      # выводит массивом
    #end
  
    #number = "orders/order/number"
    #mynumber = data.xpath(number).map {|x| x.text }                 # то же выводит массивом
    #p mynumber    
    #end
  
  
  end  
    

  # GET /orders/1
  def show 
  end

  # GET /orders/new
  def new
    @order = Order.new
        
   end
  

  # GET /orders/1/edit
  def edit
    
  end

  # POST /orders
  def create
    @order = Order.new(order_params)

    if @order.save
      redirect_to @order, notice: 'Order was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /orders/1
  def update
    if @order.update(order_params)
      redirect_to @order, notice: 'Order was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /orders/1
  def destroy
    @order.destroy
    redirect_to orders_url, notice: 'Order was successfully destroyed.'
  end

  
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_order
      @order = Order.find(params[:id])
      
    end
    

    # Only allow a trusted parameter "white list" through.
    def order_params
     params.require(:order).permit(:order_number, :order_payment_status, :work_status, :orderstatus_id, :iorders, :ionumbers)
    end
end
