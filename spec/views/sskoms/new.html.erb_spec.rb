require 'rails_helper'

RSpec.describe "sskoms/new", type: :view do
  before(:each) do
    assign(:sskom, Sskom.new(
      :title => "MyString",
      :quantity => 1
    ))
  end

  it "renders new sskom form" do
    render

    assert_select "form[action=?][method=?]", sskoms_path, "post" do

      assert_select "input#sskom_title[name=?]", "sskom[title]"

      assert_select "input#sskom_quantity[name=?]", "sskom[quantity]"
    end
  end
end
