require 'rails_helper'

RSpec.describe "companies/show", type: :view do
  before(:each) do
    @company = assign(:company, Company.create!(
      :title => "Title",
      :fulltitle => "Fulltitle",
      :uraddress => "Uraddress",
      :factaddress => "Factaddress",
      :inn => 1,
      :kpp => 2,
      :ogrn => 3,
      :okpo => 4,
      :bik => 5,
      :banktitle => "Banktitle",
      :bankaccount => 6,
      :client_id => 7
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Title/)
    expect(rendered).to match(/Fulltitle/)
    expect(rendered).to match(/Uraddress/)
    expect(rendered).to match(/Factaddress/)
    expect(rendered).to match(/1/)
    expect(rendered).to match(/2/)
    expect(rendered).to match(/3/)
    expect(rendered).to match(/4/)
    expect(rendered).to match(/5/)
    expect(rendered).to match(/Banktitle/)
    expect(rendered).to match(/6/)
    expect(rendered).to match(/7/)
  end
end
