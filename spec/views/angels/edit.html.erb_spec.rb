require 'rails_helper'

RSpec.describe "angels/edit", type: :view do
  before(:each) do
    @angel = assign(:angel, Angel.create!(
      :sku => "MyString",
      :title => "MyString",
      :quantity => 1,
      :status => "MyString",
      :valuta => "MyString",
      :price => "9.99",
      :cost_price => "9.99"
    ))
  end

  it "renders the edit angel form" do
    render

    assert_select "form[action=?][method=?]", angel_path(@angel), "post" do

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
