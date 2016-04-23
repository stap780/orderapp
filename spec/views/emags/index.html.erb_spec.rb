require 'rails_helper'

RSpec.describe "emags/index", type: :view do
  before(:each) do
    assign(:emags, [
      Emag.create!(),
      Emag.create!()
    ])
  end

  it "renders a list of emags" do
    render
  end
end
