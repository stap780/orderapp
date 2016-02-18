require 'rails_helper'

RSpec.describe "statuses/index", type: :view do
  before(:each) do
    assign(:statuses, [
      Status.create!(
        : number => 1,
        :title => "Title",
        :instatus => "Instatus"
      ),
      Status.create!(
        : number => 1,
        :title => "Title",
        :instatus => "Instatus"
      )
    ])
  end

  it "renders a list of statuses" do
    render
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => "Title".to_s, :count => 2
    assert_select "tr>td", :text => "Instatus".to_s, :count => 2
  end
end
