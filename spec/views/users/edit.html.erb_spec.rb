require 'rails_helper'

RSpec.describe "users/edit", :type => :view do
  before(:each) do
    @user = assign(:user, User.create!(
      :user_name => "MyString",
      :password => "MyString",
      :login_counter => 1
    ))
  end

  it "renders the edit user form" do
    render

    assert_select "form[action=?][method=?]", user_path(@user), "post" do

      assert_select "input#user_user_name[name=?]", "user[user_name]"

      assert_select "input#user_password[name=?]", "user[password]"

      assert_select "input#user_login_counter[name=?]", "user[login_counter]"
    end
  end
end
