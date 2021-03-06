require 'rails_helper'

RSpec.describe "clients/new", type: :view do
  before(:each) do
    assign(:client, Client.new(
      :name => "MyString",
      :middlename => "MyString",
      :surname => "MyString",
      :phone => "MyString",
      :email => "MyString",
      :zip => 1,
      :state => "MyString",
      :city => "MyString",
      :address => "MyString",
      :company_id => 1
    ))
  end

  it "renders new client form" do
    render

    assert_select "form[action=?][method=?]", clients_path, "post" do

      assert_select "input#client_name[name=?]", "client[name]"

      assert_select "input#client_middlename[name=?]", "client[middlename]"

      assert_select "input#client_surname[name=?]", "client[surname]"

      assert_select "input#client_phone[name=?]", "client[phone]"

      assert_select "input#client_email[name=?]", "client[email]"

      assert_select "input#client_zip[name=?]", "client[zip]"

      assert_select "input#client_state[name=?]", "client[state]"

      assert_select "input#client_city[name=?]", "client[city]"

      assert_select "input#client_address[name=?]", "client[address]"

      assert_select "input#client_company_id[name=?]", "client[company_id]"
    end
  end
end
