# -*- encoding : utf-8 -*-
require 'rails_helper'

RSpec.describe "orders/index", type: :view do
  before(:each) do
    assign(:orders, [
      Order.create!(
        : order_number => " Order Number",
        :order_status => "Order Status",
        :order_payment_status => "Order Payment Status"
      ),
      Order.create!(
        : order_number => " Order Number",
        :order_status => "Order Status",
        :order_payment_status => "Order Payment Status"
      )
    ])
  end

  it "renders a list of orders" do
    render
    assert_select "tr>td", :text => " Order Number".to_s, :count => 2
    assert_select "tr>td", :text => "Order Status".to_s, :count => 2
    assert_select "tr>td", :text => "Order Payment Status".to_s, :count => 2
  end
end
