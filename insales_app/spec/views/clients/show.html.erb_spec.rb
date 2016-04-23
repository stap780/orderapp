require 'rails_helper'

RSpec.describe "clients/show", type: :view do
  before(:each) do
    @client = assign(:client, Client.create!(
      :name => "Name",
      :middlename => "Middlename",
      :surname => "Surname",
      :phone => "Phone",
      :email => "Email",
      :zip => 1,
      :state => "State",
      :city => "City",
      :address => "Address",
      :company_id => 2
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/Middlename/)
    expect(rendered).to match(/Surname/)
    expect(rendered).to match(/Phone/)
    expect(rendered).to match(/Email/)
    expect(rendered).to match(/1/)
    expect(rendered).to match(/State/)
    expect(rendered).to match(/City/)
    expect(rendered).to match(/Address/)
    expect(rendered).to match(/2/)
  end
end
