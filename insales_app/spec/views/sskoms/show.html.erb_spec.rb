require 'rails_helper'

RSpec.describe "sskoms/show", type: :view do
  before(:each) do
    @sskom = assign(:sskom, Sskom.create!(
      :title => "Title",
      :quantity => 1
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Title/)
    expect(rendered).to match(/1/)
  end
end
