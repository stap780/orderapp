require 'rails_helper'

RSpec.describe "ipmatikas/edit", type: :view do
  before(:each) do
    @ipmatika = assign(:ipmatika, Ipmatika.create!(
      :title => "MyString",
      :quantity_all => 1,
      :quantity_res => 1,
      :quantity_free => 1
    ))
  end

  it "renders the edit ipmatika form" do
    render

    assert_select "form[action=?][method=?]", ipmatika_path(@ipmatika), "post" do

      assert_select "input#ipmatika_title[name=?]", "ipmatika[title]"

      assert_select "input#ipmatika_quantity_all[name=?]", "ipmatika[quantity_all]"

      assert_select "input#ipmatika_quantity_res[name=?]", "ipmatika[quantity_res]"

      assert_select "input#ipmatika_quantity_free[name=?]", "ipmatika[quantity_free]"
    end
  end
end
