require 'rails_helper'

RSpec.describe "posts/index", type: :view do
  before(:each) do
    assign(:posts, [
      Post.create!(
        :number => 1,
        :postnumber => "Postnumber",
        :state => "State"
      ),
      Post.create!(
        :number => 1,
        :postnumber => "Postnumber",
        :state => "State"
      )
    ])
  end

  it "renders a list of posts" do
    render
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => "Postnumber".to_s, :count => 2
    assert_select "tr>td", :text => "State".to_s, :count => 2
  end
end
