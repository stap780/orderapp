require 'rails_helper'

RSpec.describe "energies/index", type: :view do
  before(:each) do
    assign(:energies, [
      Energy.create!(
        :sku => "Sku",
        :title => "Title",
        :quantity => 1,
        :cost_price => "9.99",
        :price => "9.99"
      ),
      Energy.create!(
        :sku => "Sku",
        :title => "Title",
        :quantity => 1,
        :cost_price => "9.99",
        :price => "9.99"
      )
    ])
  end

  it "renders a list of energies" do
    render
    assert_select "tr>td", :text => "Sku".to_s, :count => 2
    assert_select "tr>td", :text => "Title".to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => "9.99".to_s, :count => 2
    assert_select "tr>td", :text => "9.99".to_s, :count => 2
  end
end
