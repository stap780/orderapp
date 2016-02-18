require 'rails_helper'

RSpec.describe "citilinks/show", type: :view do
  before(:each) do
    @citilink = assign(:citilink, Citilink.create!(
      :title => "",
      :price => "9.99",
      :price1 => "9.99",
      :priceusd => "9.99",
      :q1 => "Q1",
      :q2 => "Q2",
      :q3 => "Q3",
      :q4 => "Q4",
      :q5 => "Q5"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(//)
    expect(rendered).to match(/9.99/)
    expect(rendered).to match(/9.99/)
    expect(rendered).to match(/9.99/)
    expect(rendered).to match(/Q1/)
    expect(rendered).to match(/Q2/)
    expect(rendered).to match(/Q3/)
    expect(rendered).to match(/Q4/)
    expect(rendered).to match(/Q5/)
  end
end
