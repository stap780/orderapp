require 'rails_helper'

RSpec.describe "energies/new", type: :view do
  before(:each) do
    assign(:energy, Energy.new(
      :sku => "MyString",
      :title => "MyString",
      :quantity => 1,
      :cost_price => "9.99",
      :price => "9.99"
    ))
  end

  it "renders new energy form" do
    render

    assert_select "form[action=?][method=?]", energies_path, "post" do

      assert_select "input#energy_sku[name=?]", "energy[sku]"

      assert_select "input#energy_title[name=?]", "energy[title]"

      assert_select "input#energy_quantity[name=?]", "energy[quantity]"

      assert_select "input#energy_cost_price[name=?]", "energy[cost_price]"

      assert_select "input#energy_price[name=?]", "energy[price]"
    end
  end
end
