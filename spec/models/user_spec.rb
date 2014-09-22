
require 'rails_helper'

RSpec.describe User, :type => :model do
  pending "add some examples to (or delete) #{__FILE__}"
end


describe "validations" do
	it "should not allow username to have greater than 128 characters" do
		user = User.new(user_name: 'a'*129, password: 'password')
		user.valid?
		expect(user.errors[:user_name].size).to eq 1
	end

	it "should not allow identical usernames" do
		user1 = User.new(user_name: 'bob', password: 'password')
		user2 = User.new(user_name: 'bob', password: 'password')
		user2.valid?
		expect(user2.errors[:user_name].size).to eq 1
	end

	it "cannot have empty username" do
		user = User.new(user_name: '', password: 'password')
		user.valid?
		expect(user.errors[:user_name].size).to eq 1
	end

	it "should not allow password to have greater than 128 characters" do
		user = User.new(user_name: 'alice', password: 'a'*129)
		user.valid?
		expect(user.errors[:password].size).to eq 1
	end
end





