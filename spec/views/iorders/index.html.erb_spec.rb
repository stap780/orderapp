require 'rails_helper'

RSpec.describe "iorders/index", type: :view do
  before(:each) do
    assign(:iorders, [
      Iorder.create!(
        :number => 1,
        :status => "Status",
        :financial => "Financial",
        :payment => "Payment",
        :client => "Client",
        :delivery => "Delivery",
        :phone => "Phone",
        :email => "Email",
        :total => 2
      ),
      Iorder.create!(
        :number => 1,
        :status => "Status",
        :financial => "Financial",
        :payment => "Payment",
        :client => "Client",
        :delivery => "Delivery",
        :phone => "Phone",
        :email => "Email",
        :total => 2
      )
    ])
  end

  it "renders a list of iorders" do
    render
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => "Status".to_s, :count => 2
    assert_select "tr>td", :text => "Financial".to_s, :count => 2
    assert_select "tr>td", :text => "Payment".to_s, :count => 2
    assert_select "tr>td", :text => "Client".to_s, :count => 2
    assert_select "tr>td", :text => "Delivery".to_s, :count => 2
    assert_select "tr>td", :text => "Phone".to_s, :count => 2
    assert_select "tr>td", :text => "Email".to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
  end
end
