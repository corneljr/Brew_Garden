class AddTmsgAndHashtagsToProjects < ActiveRecord::Migration
  def change
  	add_column :projects, :tmsg, :string
  	add_column :projects, :hashtags, :string
  end
end
