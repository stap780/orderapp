require 'rails_helper'

RSpec.describe "dpds/index", type: :view do
  before(:each) do
    assign(:dpds, [
      Dpd.create!(
        :numer => 1,
        :dpdnumber => "Dpdnumber",
        :state => "State"
      ),
      Dpd.create!(
        :numer => 1,
        :dpdnumber => "Dpdnumber",
        :state => "State"
      )
    ])
  end

  it "renders a list of dpds" do
    render
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => "Dpdnumber".to_s, :count => 2
    assert_select "tr>td", :text => "State".to_s, :count => 2
  end
end
