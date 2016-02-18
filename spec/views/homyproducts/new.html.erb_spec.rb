require 'rails_helper'

RSpec.describe "homyproducts/new", type: :view do
  before(:each) do
    assign(:homyproduct, Homyproduct.new(
      : artikul => "MyString",
      :title => "MyString",
      :price => "9.99",
      :valuta => "MyString",
      :quantity_all_res => 1,
      :quantity_all_free => 1,
      :quantity_main_res => 1,
      :quantity_main_free => 1,
      :quantity_tul_res => 1,
      :quantity_tul_free => 1,
      :quantity_transit_all => 1,
      :quantity_transit_free => 1
    ))
  end

  it "renders new homyproduct form" do
    render

    assert_select "form[action=?][method=?]", homyproducts_path, "post" do

      assert_select "input#homyproduct_ artikul[name=?]", "homyproduct[ artikul]"

      assert_select "input#homyproduct_title[name=?]", "homyproduct[title]"

      assert_select "input#homyproduct_price[name=?]", "homyproduct[price]"

      assert_select "input#homyproduct_valuta[name=?]", "homyproduct[valuta]"

      assert_select "input#homyproduct_quantity_all_res[name=?]", "homyproduct[quantity_all_res]"

      assert_select "input#homyproduct_quantity_all_free[name=?]", "homyproduct[quantity_all_free]"

      assert_select "input#homyproduct_quantity_main_res[name=?]", "homyproduct[quantity_main_res]"

      assert_select "input#homyproduct_quantity_main_free[name=?]", "homyproduct[quantity_main_free]"

      assert_select "input#homyproduct_quantity_tul_res[name=?]", "homyproduct[quantity_tul_res]"

      assert_select "input#homyproduct_quantity_tul_free[name=?]", "homyproduct[quantity_tul_free]"

      assert_select "input#homyproduct_quantity_transit_all[name=?]", "homyproduct[quantity_transit_all]"

      assert_select "input#homyproduct_quantity_transit_free[name=?]", "homyproduct[quantity_transit_free]"
    end
  end
end
