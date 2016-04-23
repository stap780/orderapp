require 'rails_helper'

RSpec.describe "rrcs/new", type: :view do
  before(:each) do
    assign(:rrc, Rrc.new(
      :sku => "MyString",
      :title => "MyString",
      :quantity => 1
    ))
  end

  it "renders new rrc form" do
    render

    assert_select "form[action=?][method=?]", rrcs_path, "post" do

      assert_select "input#rrc_sku[name=?]", "rrc[sku]"

      assert_select "input#rrc_title[name=?]", "rrc[title]"

      assert_select "input#rrc_quantity[name=?]", "rrc[quantity]"
    end
  end
end
