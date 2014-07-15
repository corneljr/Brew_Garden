class RemoveStartDateandTiltFromProjects < ActiveRecord::Migration
  def change
  	remove_column :projects, :start_date
  	remove_column :projects, :tilt
  end
end
