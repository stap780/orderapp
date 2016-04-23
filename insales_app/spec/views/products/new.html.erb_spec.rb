require 'rails_helper'

RSpec.describe "products/new", type: :view do
  before(:each) do
    assign(:product, Product.new(
      :inid => 1,
      :title => "MyString",
      :short_description => "MyText",
      :quantity => 1,
      :cost_price => "9.99",
      :price => "9.99"
    ))
  end

  it "renders new product form" do
    render

    assert_select "form[action=?][method=?]", products_path, "post" do

      assert_select "input#product_inid[name=?]", "product[inid]"

      assert_select "input#product_title[name=?]", "product[title]"

      assert_select "textarea#product_short_description[name=?]", "product[short_description]"

      assert_select "input#product_quantity[name=?]", "product[quantity]"

      assert_select "input#product_cost_price[name=?]", "product[cost_price]"

      assert_select "input#product_price[name=?]", "product[price]"
    end
  end
end
