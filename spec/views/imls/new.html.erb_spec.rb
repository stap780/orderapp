require 'rails_helper'

RSpec.describe "imls/new", type: :view do
  before(:each) do
    assign(:iml, Iml.new(
      :number => 1,
      :state => "MyString",
      :status => "MyString",
      :barcode => 1
    ))
  end

  it "renders new iml form" do
    render

    assert_select "form[action=?][method=?]", imls_path, "post" do

      assert_select "input#iml_number[name=?]", "iml[number]"

      assert_select "input#iml_state[name=?]", "iml[state]"

      assert_select "input#iml_status[name=?]", "iml[status]"

      assert_select "input#iml_barcode[name=?]", "iml[barcode]"
    end
  end
end
