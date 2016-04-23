require 'rails_helper'

RSpec.describe "posts/edit", type: :view do
  before(:each) do
    @post = assign(:post, Post.create!(
      :number => 1,
      :postnumber => "MyString",
      :state => "MyString"
    ))
  end

  it "renders the edit post form" do
    render

    assert_select "form[action=?][method=?]", post_path(@post), "post" do

      assert_select "input#post_number[name=?]", "post[number]"

      assert_select "input#post_postnumber[name=?]", "post[postnumber]"

      assert_select "input#post_state[name=?]", "post[state]"
    end
  end
end
