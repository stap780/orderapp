require 'rails_helper'

RSpec.describe "vimcoms/edit", type: :view do
  before(:each) do
    @vimcom = assign(:vimcom, Vimcom.create!(
      :title => "MyString",
      :quantity_all => 1,
      :quantity_free => 1
    ))
  end

  it "renders the edit vimcom form" do
    render

    assert_select "form[action=?][method=?]", vimcom_path(@vimcom), "post" do

      assert_select "input#vimcom_title[name=?]", "vimcom[title]"

      assert_select "input#vimcom_quantity_all[name=?]", "vimcom[quantity_all]"

      assert_select "input#vimcom_quantity_free[name=?]", "vimcom[quantity_free]"
    end
  end
end
