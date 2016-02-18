require 'rails_helper'

RSpec.describe "dpds/new", type: :view do
  before(:each) do
    assign(:dpd, Dpd.new(
      :numer => 1,
      :dpdnumber => "MyString",
      :state => "MyString"
    ))
  end

  it "renders new dpd form" do
    render

    assert_select "form[action=?][method=?]", dpds_path, "post" do

      assert_select "input#dpd_numer[name=?]", "dpd[numer]"

      assert_select "input#dpd_dpdnumber[name=?]", "dpd[dpdnumber]"

      assert_select "input#dpd_state[name=?]", "dpd[state]"
    end
  end
end
