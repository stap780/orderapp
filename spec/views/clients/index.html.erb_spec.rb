require 'rails_helper'

RSpec.describe "clients/index", type: :view do
  before(:each) do
    assign(:clients, [
      Client.create!(
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
      ),
      Client.create!(
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
      )
    ])
  end

  it "renders a list of clients" do
    render
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "Middlename".to_s, :count => 2
    assert_select "tr>td", :text => "Surname".to_s, :count => 2
    assert_select "tr>td", :text => "Phone".to_s, :count => 2
    assert_select "tr>td", :text => "Email".to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => "State".to_s, :count => 2
    assert_select "tr>td", :text => "City".to_s, :count => 2
    assert_select "tr>td", :text => "Address".to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
  end
end
