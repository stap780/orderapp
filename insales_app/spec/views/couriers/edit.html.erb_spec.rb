require 'rails_helper'

RSpec.describe "couriers/edit", type: :view do
  before(:each) do
    @courier = assign(:courier, Courier.create!(
      :number => 1,
      :state => "MyString"
    ))
  end

  it "renders the edit courier form" do
    render

    assert_select "form[action=?][method=?]", courier_path(@courier), "post" do

      assert_select "input#courier_number[name=?]", "courier[number]"

      assert_select "input#courier_state[name=?]", "courier[state]"
    end
  end
end
