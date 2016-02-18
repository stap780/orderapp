# -*- encoding : utf-8 -*-
require 'rails_helper'

RSpec.describe "orderstatuses/index", type: :view do
  before(:each) do
    assign(:orderstatuses, [
      Orderstatus.create!(
        : title => " Title"
      ),
      Orderstatus.create!(
        : title => " Title"
      )
    ])
  end

  it "renders a list of orderstatuses" do
    render
    assert_select "tr>td", :text => " Title".to_s, :count => 2
  end
end
