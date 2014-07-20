class User < ActiveRecord::Base
	has_many :projects
	has_many :pledges


  authenticates_with_sorcery!

  validates :password, length: { minimum: 3 }
  validates :password, confirmation: true
  validates :password_confirmation, presence: true

  validates :email, uniqueness: true

  mount_uploader :avatar, AvatarUploader
end
