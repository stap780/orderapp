require 'rails_helper'

RSpec.describe "icrs/show", type: :view do
  before(:each) do
    @icr = assign(:icr, Icr.create!(
      :icr_id => 1,
      :title => "Title",
      :price_usd => "9.99",
      :price_rub => "9.99"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/1/)
    expect(rendered).to match(/Title/)
    expect(rendered).to match(/9.99/)
    expect(rendered).to match(/9.99/)
  end
end
