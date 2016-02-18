require 'rails_helper'

RSpec.describe "angels/new", type: :view do
  before(:each) do
    assign(:angel, Angel.new(
      :sku => "MyString",
      :title => "MyString",
      :quantity => 1,
      :status => "MyString",
      :valuta => "MyString",
      :price => "9.99",
      :cost_price => "9.99"
    ))
  end

  it "renders new angel form" do
    render

    assert_select "form[action=?][method=?]", angels_path, "post" do

      assert_select "input#angel_sku[name=?]", "angel[sku]"

      assert_select "input#angel_title[name=?]", "angel[title]"

      assert_select "input#angel_quantity[name=?]", "angel[quantity]"

      assert_select "input#angel_status[name=?]", "angel[status]"

      assert_select "input#angel_valuta[name=?]", "angel[valuta]"

      assert_select "input#angel_price[name=?]", "angel[price]"

      assert_select "input#angel_cost_price[name=?]", "angel[cost_price]"
    end
  end
end
