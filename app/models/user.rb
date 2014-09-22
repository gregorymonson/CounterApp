class User < ActiveRecord::Base

	validates :user_name, :password, length: {maximum: 128}
	validates :user_name, uniqueness: true
	validates :user_name, presence: true

	def add
	end

	def login
	end

	def TESTAPI_resetFixture
	end
	
end
