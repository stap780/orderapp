require 'rails_helper'

RSpec.describe "rrcs/edit", type: :view do
  before(:each) do
    @rrc = assign(:rrc, Rrc.create!(
      :sku => "MyString",
      :title => "MyString",
      :quantity => 1
    ))
  end

  it "renders the edit rrc form" do
    render

    assert_select "form[action=?][method=?]", rrc_path(@rrc), "post" do

      assert_select "input#rrc_sku[name=?]", "rrc[sku]"

      assert_select "input#rrc_title[name=?]", "rrc[title]"

      assert_select "input#rrc_quantity[name=?]", "rrc[quantity]"
    end
  end
end
