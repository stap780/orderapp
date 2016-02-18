require 'rails_helper'

RSpec.describe "imls/index", type: :view do
  before(:each) do
    assign(:imls, [
      Iml.create!(
        :number => 1,
        :state => "State",
        :status => "Status",
        :barcode => 2
      ),
      Iml.create!(
        :number => 1,
        :state => "State",
        :status => "Status",
        :barcode => 2
      )
    ])
  end

  it "renders a list of imls" do
    render
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => "State".to_s, :count => 2
    assert_select "tr>td", :text => "Status".to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
  end
end
