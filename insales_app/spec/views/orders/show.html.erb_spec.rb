# -*- encoding : utf-8 -*-
require 'rails_helper'

RSpec.describe "orders/show", type: :view do
  before(:each) do
    @order = assign(:order, Order.create!(
      : order_number => " Order Number",
      :order_status => "Order Status",
      :order_payment_status => "Order Payment Status"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/ Order Number/)
    expect(rendered).to match(/Order Status/)
    expect(rendered).to match(/Order Payment Status/)
  end
end
