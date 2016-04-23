require 'rails_helper'

RSpec.describe "energies/show", type: :view do
  before(:each) do
    @energy = assign(:energy, Energy.create!(
      :sku => "Sku",
      :title => "Title",
      :quantity => 1,
      :cost_price => "9.99",
      :price => "9.99"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Sku/)
    expect(rendered).to match(/Title/)
    expect(rendered).to match(/1/)
    expect(rendered).to match(/9.99/)
    expect(rendered).to match(/9.99/)
  end
end
