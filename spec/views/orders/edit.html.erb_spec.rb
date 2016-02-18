# -*- encoding : utf-8 -*-
require 'rails_helper'

RSpec.describe "orders/edit", type: :view do
  before(:each) do
    @order = assign(:order, Order.create!(
      : order_number => "MyString",
      :order_status => "MyString",
      :order_payment_status => "MyString"
    ))
  end

  it "renders the edit order form" do
    render

    assert_select "form[action=?][method=?]", order_path(@order), "post" do

      assert_select "input#order_ order_number[name=?]", "order[ order_number]"

      assert_select "input#order_order_status[name=?]", "order[order_status]"

      assert_select "input#order_order_payment_status[name=?]", "order[order_payment_status]"
    end
  end
end
