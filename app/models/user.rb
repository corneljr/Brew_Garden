class User < ActiveRecord::Base
	has_many :projects
	has_many :pledges
	has_many :comments

  authenticates_with_sorcery!

  validates :password, length: { minimum: 3 }
  validates :password, confirmation: true
  validates :password_confirmation, presence: true
  validates :email, uniqueness: true

  mount_uploader :avatar, AvatarUploader

  def has_backed?(project)
    to_return = false
    project.pledges.each do |pledge|
      if pledge.user_id == self.id
        to_return = true
      end
    end

    to_return
  end
end
