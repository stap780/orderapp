require 'rails_helper'

RSpec.describe "posts/new", type: :view do
  before(:each) do
    assign(:post, Post.new(
      :number => 1,
      :postnumber => "MyString",
      :state => "MyString"
    ))
  end

  it "renders new post form" do
    render

    assert_select "form[action=?][method=?]", posts_path, "post" do

      assert_select "input#post_number[name=?]", "post[number]"

      assert_select "input#post_postnumber[name=?]", "post[postnumber]"

      assert_select "input#post_state[name=?]", "post[state]"
    end
  end
end
