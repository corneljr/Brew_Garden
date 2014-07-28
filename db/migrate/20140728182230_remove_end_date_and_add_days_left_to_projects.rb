class RemoveEndDateAndAddDaysLeftToProjects < ActiveRecord::Migration
  def change
  	remove_column :projects, :end_date
  	add_column :projects, :days_left, :integer
  end
end
