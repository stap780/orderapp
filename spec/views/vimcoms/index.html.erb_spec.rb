require 'rails_helper'

RSpec.describe "vimcoms/index", type: :view do
  before(:each) do
    assign(:vimcoms, [
      Vimcom.create!(
        :title => "Title",
        :quantity_all => 1,
        :quantity_free => 2
      ),
      Vimcom.create!(
        :title => "Title",
        :quantity_all => 1,
        :quantity_free => 2
      )
    ])
  end

  it "renders a list of vimcoms" do
    render
    assert_select "tr>td", :text => "Title".to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
  end
end
