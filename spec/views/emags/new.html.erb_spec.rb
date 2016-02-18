require 'rails_helper'

RSpec.describe "emags/new", type: :view do
  before(:each) do
    assign(:emag, Emag.new())
  end

  it "renders new emag form" do
    render

    assert_select "form[action=?][method=?]", emags_path, "post" do
    end
  end
end
