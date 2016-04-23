require 'rails_helper'

RSpec.describe "statuses/new", type: :view do
  before(:each) do
    assign(:status, Status.new(
      : number => 1,
      :title => "MyString",
      :instatus => "MyString"
    ))
  end

  it "renders new status form" do
    render

    assert_select "form[action=?][method=?]", statuses_path, "post" do

      assert_select "input#status_ number[name=?]", "status[ number]"

      assert_select "input#status_title[name=?]", "status[title]"

      assert_select "input#status_instatus[name=?]", "status[instatus]"
    end
  end
end
