require 'rails_helper'

RSpec.describe "sskoms/edit", type: :view do
  before(:each) do
    @sskom = assign(:sskom, Sskom.create!(
      :title => "MyString",
      :quantity => 1
    ))
  end

  it "renders the edit sskom form" do
    render

    assert_select "form[action=?][method=?]", sskom_path(@sskom), "post" do

      assert_select "input#sskom_title[name=?]", "sskom[title]"

      assert_select "input#sskom_quantity[name=?]", "sskom[quantity]"
    end
  end
end
