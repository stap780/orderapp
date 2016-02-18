require 'rails_helper'

RSpec.describe "icrs/index", type: :view do
  before(:each) do
    assign(:icrs, [
      Icr.create!(
        :icr_id => 1,
        :title => "Title",
        :price_usd => "9.99",
        :price_rub => "9.99"
      ),
      Icr.create!(
        :icr_id => 1,
        :title => "Title",
        :price_usd => "9.99",
        :price_rub => "9.99"
      )
    ])
  end

  it "renders a list of icrs" do
    render
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => "Title".to_s, :count => 2
    assert_select "tr>td", :text => "9.99".to_s, :count => 2
    assert_select "tr>td", :text => "9.99".to_s, :count => 2
  end
end
