# -*- encoding : utf-8 -*-
require 'rails_helper'

RSpec.describe "orderstatuses/edit", type: :view do
  before(:each) do
    @orderstatus = assign(:orderstatus, Orderstatus.create!(
      : title => "MyString"
    ))
  end

  it "renders the edit orderstatus form" do
    render

    assert_select "form[action=?][method=?]", orderstatus_path(@orderstatus), "post" do

      assert_select "input#orderstatus_ title[name=?]", "orderstatus[ title]"
    end
  end
end
