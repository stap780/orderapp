require 'rails_helper'

RSpec.describe "ipmatikas/new", type: :view do
  before(:each) do
    assign(:ipmatika, Ipmatika.new(
      :title => "MyString",
      :quantity_all => 1,
      :quantity_res => 1,
      :quantity_free => 1
    ))
  end

  it "renders new ipmatika form" do
    render

    assert_select "form[action=?][method=?]", ipmatikas_path, "post" do

      assert_select "input#ipmatika_title[name=?]", "ipmatika[title]"

      assert_select "input#ipmatika_quantity_all[name=?]", "ipmatika[quantity_all]"

      assert_select "input#ipmatika_quantity_res[name=?]", "ipmatika[quantity_res]"

      assert_select "input#ipmatika_quantity_free[name=?]", "ipmatika[quantity_free]"
    end
  end
end
