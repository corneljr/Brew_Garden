class RemoveTmsgFromProjects < ActiveRecord::Migration
  def change
  	remove_column :projects, :tmsg
  end
end
