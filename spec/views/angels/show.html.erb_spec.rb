require 'rails_helper'

RSpec.describe "angels/show", type: :view do
  before(:each) do
    @angel = assign(:angel, Angel.create!(
      :sku => "Sku",
      :title => "Title",
      :quantity => 1,
      :status => "Status",
      :valuta => "Valuta",
      :price => "9.99",
      :cost_price => "9.99"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Sku/)
    expect(rendered).to match(/Title/)
    expect(rendered).to match(/1/)
    expect(rendered).to match(/Status/)
    expect(rendered).to match(/Valuta/)
    expect(rendered).to match(/9.99/)
    expect(rendered).to match(/9.99/)
  end
end
