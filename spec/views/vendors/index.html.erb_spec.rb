require 'rails_helper'

RSpec.describe "vendors/index", type: :view do
  before(:each) do
    assign(:vendors, [
      Vendor.create!(
        :title => "Title"
      ),
      Vendor.create!(
        :title => "Title"
      )
    ])
  end

  it "renders a list of vendors" do
    render
    assert_select "tr>td", :text => "Title".to_s, :count => 2
  end
end
