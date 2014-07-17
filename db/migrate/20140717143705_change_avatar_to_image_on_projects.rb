class ChangeAvatarToImageOnProjects < ActiveRecord::Migration
  def change
  	remove_column :projects, :avatar
  	add_column :projects, :image, :string
  end
end
