require 'rails_helper'

RSpec.describe "sskoms/index", type: :view do
  before(:each) do
    assign(:sskoms, [
      Sskom.create!(
        :title => "Title",
        :quantity => 1
      ),
      Sskom.create!(
        :title => "Title",
        :quantity => 1
      )
    ])
  end

  it "renders a list of sskoms" do
    render
    assert_select "tr>td", :text => "Title".to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
  end
end
