require 'rails_helper'

RSpec.describe "icrs/edit", type: :view do
  before(:each) do
    @icr = assign(:icr, Icr.create!(
      :icr_id => 1,
      :title => "MyString",
      :price_usd => "9.99",
      :price_rub => "9.99"
    ))
  end

  it "renders the edit icr form" do
    render

    assert_select "form[action=?][method=?]", icr_path(@icr), "post" do

      assert_select "input#icr_icr_id[name=?]", "icr[icr_id]"

      assert_select "input#icr_title[name=?]", "icr[title]"

      assert_select "input#icr_price_usd[name=?]", "icr[price_usd]"

      assert_select "input#icr_price_rub[name=?]", "icr[price_rub]"
    end
  end
end
