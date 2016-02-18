require 'rails_helper'

RSpec.describe "mycouriers/edit", type: :view do
  before(:each) do
    @mycourier = assign(:mycourier, Mycourier.create!(
      :title => "MyString"
    ))
  end

  it "renders the edit mycourier form" do
    render

    assert_select "form[action=?][method=?]", mycourier_path(@mycourier), "post" do

      assert_select "input#mycourier_title[name=?]", "mycourier[title]"
    end
  end
end
