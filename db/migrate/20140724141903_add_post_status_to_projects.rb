class AddPostStatusToProjects < ActiveRecord::Migration
  def change
    add_column :projects, :post_status, :boolean, default: false
  end
end
