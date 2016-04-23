require 'rails_helper'

RSpec.describe "iorders/show", type: :view do
  before(:each) do
    @iorder = assign(:iorder, Iorder.create!(
      :number => 1,
      :status => "Status",
      :financial => "Financial",
      :payment => "Payment",
      :client => "Client",
      :delivery => "Delivery",
      :phone => "Phone",
      :email => "Email",
      :total => 2
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/1/)
    expect(rendered).to match(/Status/)
    expect(rendered).to match(/Financial/)
    expect(rendered).to match(/Payment/)
    expect(rendered).to match(/Client/)
    expect(rendered).to match(/Delivery/)
    expect(rendered).to match(/Phone/)
    expect(rendered).to match(/Email/)
    expect(rendered).to match(/2/)
  end
end
