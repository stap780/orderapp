require 'rails_helper'

RSpec.describe "icrs/new", type: :view do
  before(:each) do
    assign(:icr, Icr.new(
      :icr_id => 1,
      :title => "MyString",
      :price_usd => "9.99",
      :price_rub => "9.99"
    ))
  end

  it "renders new icr form" do
    render

    assert_select "form[action=?][method=?]", icrs_path, "post" do

      assert_select "input#icr_icr_id[name=?]", "icr[icr_id]"

      assert_select "input#icr_title[name=?]", "icr[title]"

      assert_select "input#icr_price_usd[name=?]", "icr[price_usd]"

      assert_select "input#icr_price_rub[name=?]", "icr[price_rub]"
    end
  end
end
