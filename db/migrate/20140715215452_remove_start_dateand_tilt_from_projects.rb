class RemoveStartDateandTiltFromProjects < ActiveRecord::Migration
  def change
  	remove_column :projects, :start_date
  end
end
