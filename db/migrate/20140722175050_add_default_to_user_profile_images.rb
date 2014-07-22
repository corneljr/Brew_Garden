class AddDefaultToUserProfileImages < ActiveRecord::Migration
  def change
  	change_column :users, :avatar, :string, default: 'default_profile.png'
  end
end
