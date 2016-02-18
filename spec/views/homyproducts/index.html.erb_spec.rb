require 'rails_helper'

RSpec.describe "homyproducts/index", type: :view do
  before(:each) do
    assign(:homyproducts, [
      Homyproduct.create!(
        : artikul => " Artikul",
        :title => "Title",
        :price => "9.99",
        :valuta => "Valuta",
        :quantity_all_res => 1,
        :quantity_all_free => 2,
        :quantity_main_res => 3,
        :quantity_main_free => 4,
        :quantity_tul_res => 5,
        :quantity_tul_free => 6,
        :quantity_transit_all => 7,
        :quantity_transit_free => 8
      ),
      Homyproduct.create!(
        : artikul => " Artikul",
        :title => "Title",
        :price => "9.99",
        :valuta => "Valuta",
        :quantity_all_res => 1,
        :quantity_all_free => 2,
        :quantity_main_res => 3,
        :quantity_main_free => 4,
        :quantity_tul_res => 5,
        :quantity_tul_free => 6,
        :quantity_transit_all => 7,
        :quantity_transit_free => 8
      )
    ])
  end

  it "renders a list of homyproducts" do
    render
    assert_select "tr>td", :text => " Artikul".to_s, :count => 2
    assert_select "tr>td", :text => "Title".to_s, :count => 2
    assert_select "tr>td", :text => "9.99".to_s, :count => 2
    assert_select "tr>td", :text => "Valuta".to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => 3.to_s, :count => 2
    assert_select "tr>td", :text => 4.to_s, :count => 2
    assert_select "tr>td", :text => 5.to_s, :count => 2
    assert_select "tr>td", :text => 6.to_s, :count => 2
    assert_select "tr>td", :text => 7.to_s, :count => 2
    assert_select "tr>td", :text => 8.to_s, :count => 2
  end
end
