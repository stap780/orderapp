require 'rails_helper'

RSpec.describe "vendors/edit", type: :view do
  before(:each) do
    @vendor = assign(:vendor, Vendor.create!(
      :title => "MyString"
    ))
  end

  it "renders the edit vendor form" do
    render

    assert_select "form[action=?][method=?]", vendor_path(@vendor), "post" do

      assert_select "input#vendor_title[name=?]", "vendor[title]"
    end
  end
end
