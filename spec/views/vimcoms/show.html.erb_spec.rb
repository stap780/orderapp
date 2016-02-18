require 'rails_helper'

RSpec.describe "vimcoms/show", type: :view do
  before(:each) do
    @vimcom = assign(:vimcom, Vimcom.create!(
      :title => "Title",
      :quantity_all => 1,
      :quantity_free => 2
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Title/)
    expect(rendered).to match(/1/)
    expect(rendered).to match(/2/)
  end
end
