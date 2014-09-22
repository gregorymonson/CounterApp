require 'rails_helper'

RSpec.describe "users/show", :type => :view do
  before(:each) do
    @user = assign(:user, User.create!(
      :user_name => "User Name",
      :password => "Password",
      :login_counter => 1
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/User Name/)
    expect(rendered).to match(/Password/)
    expect(rendered).to match(/1/)
  end
end
