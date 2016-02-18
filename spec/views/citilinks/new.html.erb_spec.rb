require 'rails_helper'

RSpec.describe "citilinks/new", type: :view do
  before(:each) do
    assign(:citilink, Citilink.new(
      :title => "",
      :price => "9.99",
      :price1 => "9.99",
      :priceusd => "9.99",
      :q1 => "MyString",
      :q2 => "MyString",
      :q3 => "MyString",
      :q4 => "MyString",
      :q5 => "MyString"
    ))
  end

  it "renders new citilink form" do
    render

    assert_select "form[action=?][method=?]", citilinks_path, "post" do

      assert_select "input#citilink_title[name=?]", "citilink[title]"

      assert_select "input#citilink_price[name=?]", "citilink[price]"

      assert_select "input#citilink_price1[name=?]", "citilink[price1]"

      assert_select "input#citilink_priceusd[name=?]", "citilink[priceusd]"

      assert_select "input#citilink_q1[name=?]", "citilink[q1]"

      assert_select "input#citilink_q2[name=?]", "citilink[q2]"

      assert_select "input#citilink_q3[name=?]", "citilink[q3]"

      assert_select "input#citilink_q4[name=?]", "citilink[q4]"

      assert_select "input#citilink_q5[name=?]", "citilink[q5]"
    end
  end
end
