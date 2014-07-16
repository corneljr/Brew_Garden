class User < ActiveRecord::Base
	has_secure_password

	validates :name, presence: true
	validates :email, presence: true, uniqueness: true
	validates :password, length: { in: 6..20 }, confirmation: true

	has_many :projects
	has_many :pledges

end
