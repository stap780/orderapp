require 'rails_helper'

RSpec.describe "mycouriers/new", type: :view do
  before(:each) do
    assign(:mycourier, Mycourier.new(
      :title => "MyString"
    ))
  end

  it "renders new mycourier form" do
    render

    assert_select "form[action=?][method=?]", mycouriers_path, "post" do

      assert_select "input#mycourier_title[name=?]", "mycourier[title]"
    end
  end
end
