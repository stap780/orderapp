# -*- encoding : utf-8 -*-
require 'rails_helper'

RSpec.describe "orderstatuses/new", type: :view do
  before(:each) do
    assign(:orderstatus, Orderstatus.new(
      : title => "MyString"
    ))
  end

  it "renders new orderstatus form" do
    render

    assert_select "form[action=?][method=?]", orderstatuses_path, "post" do

      assert_select "input#orderstatus_ title[name=?]", "orderstatus[ title]"
    end
  end
end
