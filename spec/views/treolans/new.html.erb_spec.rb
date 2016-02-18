require 'rails_helper'

RSpec.describe "treolans/new", type: :view do
  before(:each) do
    assign(:treolan, Treolan.new(
      :sku => "MyString",
      :title => "MyString",
      :quantity => 1,
      :transit => 1,
      :price => "9.99"
    ))
  end

  it "renders new treolan form" do
    render

    assert_select "form[action=?][method=?]", treolans_path, "post" do

      assert_select "input#treolan_sku[name=?]", "treolan[sku]"

      assert_select "input#treolan_title[name=?]", "treolan[title]"

      assert_select "input#treolan_quantity[name=?]", "treolan[quantity]"

      assert_select "input#treolan_transit[name=?]", "treolan[transit]"

      assert_select "input#treolan_price[name=?]", "treolan[price]"
    end
  end
end
