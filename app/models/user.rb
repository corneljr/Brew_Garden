class User < ActiveRecord::Base
	has_many :projects
	has_many :pledges
	has_many :comments

  # Originally added to help get user type like User.brewer.all
  # but this is not really if you use Single Table Inheritance
  # now you can call Brewer.all, Funder.all
  # scope :brewer, -> { where( type: 'brewer' ) }
  # scope :funder, -> { where( type: 'funder' ) }

  authenticates_with_sorcery!

  validates :password, length: { minimum: 3 }
  validates :password, confirmation: true
  validates :password_confirmation, presence: true
  validates :email, uniqueness: true
  validates :type, presence: true

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