require 'rails_helper'

RSpec.describe "companies/index", type: :view do
  before(:each) do
    assign(:companies, [
      Company.create!(
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
      ),
      Company.create!(
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
      )
    ])
  end

  it "renders a list of companies" do
    render
    assert_select "tr>td", :text => "Title".to_s, :count => 2
    assert_select "tr>td", :text => "Fulltitle".to_s, :count => 2
    assert_select "tr>td", :text => "Uraddress".to_s, :count => 2
    assert_select "tr>td", :text => "Factaddress".to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => 3.to_s, :count => 2
    assert_select "tr>td", :text => 4.to_s, :count => 2
    assert_select "tr>td", :text => 5.to_s, :count => 2
    assert_select "tr>td", :text => "Banktitle".to_s, :count => 2
    assert_select "tr>td", :text => 6.to_s, :count => 2
    assert_select "tr>td", :text => 7.to_s, :count => 2
  end
end
