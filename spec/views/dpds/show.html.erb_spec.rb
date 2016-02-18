require 'rails_helper'

RSpec.describe "dpds/show", type: :view do
  before(:each) do
    @dpd = assign(:dpd, Dpd.create!(
      :numer => 1,
      :dpdnumber => "Dpdnumber",
      :state => "State"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/1/)
    expect(rendered).to match(/Dpdnumber/)
    expect(rendered).to match(/State/)
  end
end
