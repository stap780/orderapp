require 'rails_helper'

RSpec.describe "treolans/index", type: :view do
  before(:each) do
    assign(:treolans, [
      Treolan.create!(
        :sku => "Sku",
        :title => "Title",
        :quantity => 1,
        :transit => 2,
        :price => "9.99"
      ),
      Treolan.create!(
        :sku => "Sku",
        :title => "Title",
        :quantity => 1,
        :transit => 2,
        :price => "9.99"
      )
    ])
  end

  it "renders a list of treolans" do
    render
    assert_select "tr>td", :text => "Sku".to_s, :count => 2
    assert_select "tr>td", :text => "Title".to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => "9.99".to_s, :count => 2
  end
end
