require 'rails_helper'

RSpec.describe "imls/show", type: :view do
  before(:each) do
    @iml = assign(:iml, Iml.create!(
      :number => 1,
      :state => "State",
      :status => "Status",
      :barcode => 2
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/1/)
    expect(rendered).to match(/State/)
    expect(rendered).to match(/Status/)
    expect(rendered).to match(/2/)
  end
end
