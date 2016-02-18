require 'rails_helper'

RSpec.describe "statuses/edit", type: :view do
  before(:each) do
    @status = assign(:status, Status.create!(
      : number => 1,
      :title => "MyString",
      :instatus => "MyString"
    ))
  end

  it "renders the edit status form" do
    render

    assert_select "form[action=?][method=?]", status_path(@status), "post" do

      assert_select "input#status_ number[name=?]", "status[ number]"

      assert_select "input#status_title[name=?]", "status[title]"

      assert_select "input#status_instatus[name=?]", "status[instatus]"
    end
  end
end
