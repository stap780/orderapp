require 'rails_helper'

RSpec.describe "homyproducts/show", type: :view do
  before(:each) do
    @homyproduct = assign(:homyproduct, Homyproduct.create!(
      : artikul => " Artikul",
      :title => "Title",
      :price => "9.99",
      :valuta => "Valuta",
      :quantity_all_res => 1,
      :quantity_all_free => 2,
      :quantity_main_res => 3,
      :quantity_main_free => 4,
      :quantity_tul_res => 5,
      :quantity_tul_free => 6,
      :quantity_transit_all => 7,
      :quantity_transit_free => 8
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/ Artikul/)
    expect(rendered).to match(/Title/)
    expect(rendered).to match(/9.99/)
    expect(rendered).to match(/Valuta/)
    expect(rendered).to match(/1/)
    expect(rendered).to match(/2/)
    expect(rendered).to match(/3/)
    expect(rendered).to match(/4/)
    expect(rendered).to match(/5/)
    expect(rendered).to match(/6/)
    expect(rendered).to match(/7/)
    expect(rendered).to match(/8/)
  end
end
