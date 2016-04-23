require 'rails_helper'

RSpec.describe "emags/show", type: :view do
  before(:each) do
    @emag = assign(:emag, Emag.create!())
  end

  it "renders attributes in <p>" do
    render
  end
end
