require 'rails_helper'

RSpec.describe "ipmatikas/index", type: :view do
  before(:each) do
    assign(:ipmatikas, [
      Ipmatika.create!(
        :title => "Title",
        :quantity_all => 1,
        :quantity_res => 2,
        :quantity_free => 3
      ),
      Ipmatika.create!(
        :title => "Title",
        :quantity_all => 1,
        :quantity_res => 2,
        :quantity_free => 3
      )
    ])
  end

  it "renders a list of ipmatikas" do
    render
    assert_select "tr>td", :text => "Title".to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => 3.to_s, :count => 2
  end
end
