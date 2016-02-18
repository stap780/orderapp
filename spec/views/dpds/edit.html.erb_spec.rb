require 'rails_helper'

RSpec.describe "dpds/edit", type: :view do
  before(:each) do
    @dpd = assign(:dpd, Dpd.create!(
      :numer => 1,
      :dpdnumber => "MyString",
      :state => "MyString"
    ))
  end

  it "renders the edit dpd form" do
    render

    assert_select "form[action=?][method=?]", dpd_path(@dpd), "post" do

      assert_select "input#dpd_numer[name=?]", "dpd[numer]"

      assert_select "input#dpd_dpdnumber[name=?]", "dpd[dpdnumber]"

      assert_select "input#dpd_state[name=?]", "dpd[state]"
    end
  end
end
