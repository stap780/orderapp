require 'rails_helper'

RSpec.describe "couriers/index", type: :view do
  before(:each) do
    assign(:couriers, [
      Courier.create!(
        :number => 1,
        :state => "State"
      ),
      Courier.create!(
        :number => 1,
        :state => "State"
      )
    ])
  end

  it "renders a list of couriers" do
    render
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => "State".to_s, :count => 2
  end
end
