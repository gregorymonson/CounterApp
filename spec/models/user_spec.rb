
require 'rails_helper'

RSpec.describe User, :type => :model do
  

	describe "validations" do
		it "should not allow username to be too long" do
			user = User.new(user_name: 'a'*129, password: 'password')
			user.valid?
			expect(user.errors[:user_name].size).to eq 1
		end

		it "should not allow identical usernames" do
			User.create!(user_name: 'bob', password: 'password')
			user2 = User.new(user_name: 'bob', password: 'password')
			user2.valid?
			expect(user2.errors[:user_name].size).to eq 1
		end

		it "cannot have empty username" do
			user = User.new(user_name: '', password: 'password')
			user.valid?
			expect(user.errors[:user_name].size).to eq 1
		end

		it "should not allow password to be too long" do
			user = User.new(user_name: 'alice', password: 'a'*129)
			user.valid?
			expect(user.errors[:password].size).to eq 1
		end
	end

	describe "error codes" do
		it "should have correct error code for empty user_name" do
		expect(User.add('', '')).to eq -3
	    end

	    it "should have correct error code for too long user_name" do
	    	expect(User.add('a'*129, '')).to eq -3
	    end

	    it "should have correct error code for too long password" do
	    	expect(User.add('alice', 'a'*129)).to eq -4
	    end

	    it "should have correct error code for creating user with same user_name" do
	    	User.add('bob', '')
	    	expect(User.add('bob', 'alice')).to eq -2
	    end

	    it "should have correct error code for incorrect password" do
	    	User.add('me', 'abc')
	    	expect(User.login('me', 'cba')).to eq -1
	    end

	    it "should have correct error code for wrong username" do
	    	User.add('me', 'abc')
	    	expect(User.login('Me', 'abc')).to eq -1
	    end
	end

	describe "successful behavior" do
		it "should return 1 when new user is successfully added" do
			expect(User.add('bob', '')).to eq 1
		end

		it "should update login_counter with multiple logins" do
			User.add('bob', '')
			expect(User.login('bob', '')).to eq 2
			expect(User.login('bob', '')).to eq 3
		end
	end

end




