require 'rails_helper'

RSpec.describe "treolans/show", type: :view do
  before(:each) do
    @treolan = assign(:treolan, Treolan.create!(
      :sku => "Sku",
      :title => "Title",
      :quantity => 1,
      :transit => 2,
      :price => "9.99"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Sku/)
    expect(rendered).to match(/Title/)
    expect(rendered).to match(/1/)
    expect(rendered).to match(/2/)
    expect(rendered).to match(/9.99/)
  end
end
