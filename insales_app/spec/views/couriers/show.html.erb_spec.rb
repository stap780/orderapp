require 'rails_helper'

RSpec.describe "couriers/show", type: :view do
  before(:each) do
    @courier = assign(:courier, Courier.create!(
      :number => 1,
      :state => "State"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/1/)
    expect(rendered).to match(/State/)
  end
end
