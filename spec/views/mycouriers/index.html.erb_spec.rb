require 'rails_helper'

RSpec.describe "mycouriers/index", type: :view do
  before(:each) do
    assign(:mycouriers, [
      Mycourier.create!(
        :title => "Title"
      ),
      Mycourier.create!(
        :title => "Title"
      )
    ])
  end

  it "renders a list of mycouriers" do
    render
    assert_select "tr>td", :text => "Title".to_s, :count => 2
  end
end
