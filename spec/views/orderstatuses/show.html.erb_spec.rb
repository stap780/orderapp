# -*- encoding : utf-8 -*-
require 'rails_helper'

RSpec.describe "orderstatuses/show", type: :view do
  before(:each) do
    @orderstatus = assign(:orderstatus, Orderstatus.create!(
      : title => " Title"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/ Title/)
  end
end
