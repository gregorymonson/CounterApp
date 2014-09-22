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

	def add
	end

	def login
	end

	def TESTAPI_resetFixture
	end

end
