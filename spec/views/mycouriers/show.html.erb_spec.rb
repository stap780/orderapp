require 'rails_helper'

RSpec.describe "mycouriers/show", type: :view do
  before(:each) do
    @mycourier = assign(:mycourier, Mycourier.create!(
      :title => "Title"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Title/)
  end
end
