require 'rails_helper'

RSpec.describe "couriers/new", type: :view do
  before(:each) do
    assign(:courier, Courier.new(
      :number => 1,
      :state => "MyString"
    ))
  end

  it "renders new courier form" do
    render

    assert_select "form[action=?][method=?]", couriers_path, "post" do

      assert_select "input#courier_number[name=?]", "courier[number]"

      assert_select "input#courier_state[name=?]", "courier[state]"
    end
  end
end
