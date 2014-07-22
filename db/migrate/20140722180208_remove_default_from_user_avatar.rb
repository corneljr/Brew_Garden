class RemoveDefaultFromUserAvatar < ActiveRecord::Migration
  def change
  	remove_column :users, :avatar
  	add_column :users, :avatar, :string
  end
end
