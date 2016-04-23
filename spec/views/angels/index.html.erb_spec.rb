require 'rails_helper'

RSpec.describe "angels/index", type: :view do
  before(:each) do
    assign(:angels, [
      Angel.create!(
        :sku => "Sku",
        :title => "Title",
        :quantity => 1,
        :status => "Status",
        :valuta => "Valuta",
        :price => "9.99",
        :cost_price => "9.99"
      ),
      Angel.create!(
        :sku => "Sku",
        :title => "Title",
        :quantity => 1,
        :status => "Status",
        :valuta => "Valuta",
        :price => "9.99",
        :cost_price => "9.99"
      )
    ])
  end

  it "renders a list of angels" do
    render
    assert_select "tr>td", :text => "Sku".to_s, :count => 2
    assert_select "tr>td", :text => "Title".to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => "Status".to_s, :count => 2
    assert_select "tr>td", :text => "Valuta".to_s, :count => 2
    assert_select "tr>td", :text => "9.99".to_s, :count => 2
    assert_select "tr>td", :text => "9.99".to_s, :count => 2
  end
end
