require 'rails_helper'

RSpec.describe "companies/new", type: :view do
  before(:each) do
    assign(:company, Company.new(
      :title => "MyString",
      :fulltitle => "MyString",
      :uraddress => "MyString",
      :factaddress => "MyString",
      :inn => 1,
      :kpp => 1,
      :ogrn => 1,
      :okpo => 1,
      :bik => 1,
      :banktitle => "MyString",
      :bankaccount => 1,
      :client_id => 1
    ))
  end

  it "renders new company form" do
    render

    assert_select "form[action=?][method=?]", companies_path, "post" do

      assert_select "input#company_title[name=?]", "company[title]"

      assert_select "input#company_fulltitle[name=?]", "company[fulltitle]"

      assert_select "input#company_uraddress[name=?]", "company[uraddress]"

      assert_select "input#company_factaddress[name=?]", "company[factaddress]"

      assert_select "input#company_inn[name=?]", "company[inn]"

      assert_select "input#company_kpp[name=?]", "company[kpp]"

      assert_select "input#company_ogrn[name=?]", "company[ogrn]"

      assert_select "input#company_okpo[name=?]", "company[okpo]"

      assert_select "input#company_bik[name=?]", "company[bik]"

      assert_select "input#company_banktitle[name=?]", "company[banktitle]"

      assert_select "input#company_bankaccount[name=?]", "company[bankaccount]"

      assert_select "input#company_client_id[name=?]", "company[client_id]"
    end
  end
end
