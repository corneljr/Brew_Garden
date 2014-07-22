class AddVideoLinkToProjects < ActiveRecord::Migration
  def change
    add_column :projects, :video_link, :string
  end
end
