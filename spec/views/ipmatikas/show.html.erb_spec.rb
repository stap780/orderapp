require 'rails_helper'

RSpec.describe "ipmatikas/show", type: :view do
  before(:each) do
    @ipmatika = assign(:ipmatika, Ipmatika.create!(
      :title => "Title",
      :quantity_all => 1,
      :quantity_res => 2,
      :quantity_free => 3
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Title/)
    expect(rendered).to match(/1/)
    expect(rendered).to match(/2/)
    expect(rendered).to match(/3/)
  end
end
