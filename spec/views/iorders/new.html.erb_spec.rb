require 'rails_helper'

RSpec.describe "iorders/new", type: :view do
  before(:each) do
    assign(:iorder, Iorder.new(
      :number => 1,
      :status => "MyString",
      :financial => "MyString",
      :payment => "MyString",
      :client => "MyString",
      :delivery => "MyString",
      :phone => "MyString",
      :email => "MyString",
      :total => 1
    ))
  end

  it "renders new iorder form" do
    render

    assert_select "form[action=?][method=?]", iorders_path, "post" do

      assert_select "input#iorder_number[name=?]", "iorder[number]"

      assert_select "input#iorder_status[name=?]", "iorder[status]"

      assert_select "input#iorder_financial[name=?]", "iorder[financial]"

      assert_select "input#iorder_payment[name=?]", "iorder[payment]"

      assert_select "input#iorder_client[name=?]", "iorder[client]"

      assert_select "input#iorder_delivery[name=?]", "iorder[delivery]"

      assert_select "input#iorder_phone[name=?]", "iorder[phone]"

      assert_select "input#iorder_email[name=?]", "iorder[email]"

      assert_select "input#iorder_total[name=?]", "iorder[total]"
    end
  end
end
