class User < ActiveRecord::Base

	MAX_PASSWORD_LENGTH = 128
	MAX_USERNAME_LENGTH = 128

	SUCCESS = 1
	ERR_BAD_CREDENTIALS = -1
	ERR_BAD_PASSWORD = -4
	ERR_BAD_USERNAME = -3
	ERR_USER_EXISTS = -2

	validates :user_name, length: {maximum: MAX_USERNAME_LENGTH}
	validates :password, length: {maximum: MAX_PASSWORD_LENGTH}
	validates :user_name, uniqueness: true
	validates :user_name, presence: true

	def self.add(user_name, password) ###FIXME
		new_user = User.new(user_name: user_name, password: password)
		
		if new_user.valid?
			new_user.save
			return new_user[:login_counter]
		else
			case
			when !new_user[:user_name].present?
				return ERR_BAD_USERNAME
			when new_user[:user_name].size > MAX_USERNAME_LENGTH
				return ERR_BAD_USERNAME
			when User.where(user_name: user_name).all.size == 1
				return ERR_USER_EXISTS
			when new_user[:password].size > MAX_PASSWORD_LENGTH
				return ERR_BAD_PASSWORD
			end
		end
	end

	def self.login(user_name, password)
		user = User.where(user_name: user_name, password: password)
		if user.size == 0
			return ERR_BAD_CREDENTIALS
		else
			user.first[:login_counter] += 1
			user.first.save
			return user.first[:login_counter]
		end
	end

	def self.TESTAPI_resetFixture()
		User.delete_all
		return SUCCESS
	end

	def self.runUnitTests()
		return %x[rspec spec/models]
	end

end
