require 'rails_helper'

RSpec.describe "citilinks/index", type: :view do
  before(:each) do
    assign(:citilinks, [
      Citilink.create!(
        :title => "",
        :price => "9.99",
        :price1 => "9.99",
        :priceusd => "9.99",
        :q1 => "Q1",
        :q2 => "Q2",
        :q3 => "Q3",
        :q4 => "Q4",
        :q5 => "Q5"
      ),
      Citilink.create!(
        :title => "",
        :price => "9.99",
        :price1 => "9.99",
        :priceusd => "9.99",
        :q1 => "Q1",
        :q2 => "Q2",
        :q3 => "Q3",
        :q4 => "Q4",
        :q5 => "Q5"
      )
    ])
  end

  it "renders a list of citilinks" do
    render
    assert_select "tr>td", :text => "".to_s, :count => 2
    assert_select "tr>td", :text => "9.99".to_s, :count => 2
    assert_select "tr>td", :text => "9.99".to_s, :count => 2
    assert_select "tr>td", :text => "9.99".to_s, :count => 2
    assert_select "tr>td", :text => "Q1".to_s, :count => 2
    assert_select "tr>td", :text => "Q2".to_s, :count => 2
    assert_select "tr>td", :text => "Q3".to_s, :count => 2
    assert_select "tr>td", :text => "Q4".to_s, :count => 2
    assert_select "tr>td", :text => "Q5".to_s, :count => 2
  end
end
