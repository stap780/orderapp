require 'rails_helper'

RSpec.describe "emags/edit", type: :view do
  before(:each) do
    @emag = assign(:emag, Emag.create!())
  end

  it "renders the edit emag form" do
    render

    assert_select "form[action=?][method=?]", emag_path(@emag), "post" do
    end
  end
end
