require 'rails_helper'

RSpec.describe "rrcs/index", type: :view do
  before(:each) do
    assign(:rrcs, [
      Rrc.create!(
        :sku => "Sku",
        :title => "Title",
        :quantity => 1
      ),
      Rrc.create!(
        :sku => "Sku",
        :title => "Title",
        :quantity => 1
      )
    ])
  end

  it "renders a list of rrcs" do
    render
    assert_select "tr>td", :text => "Sku".to_s, :count => 2
    assert_select "tr>td", :text => "Title".to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
  end
end
