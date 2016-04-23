require 'rails_helper'

RSpec.describe "rrcs/show", type: :view do
  before(:each) do
    @rrc = assign(:rrc, Rrc.create!(
      :sku => "Sku",
      :title => "Title",
      :quantity => 1
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Sku/)
    expect(rendered).to match(/Title/)
    expect(rendered).to match(/1/)
  end
end
