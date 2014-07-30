class RemoveTwitterFromProject < ActiveRecord::Migration
  def change
  	remove_column :projects, :message
  	remove_column :projects, :hashtags
  end
end
