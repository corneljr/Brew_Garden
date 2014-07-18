class AddPlegesLeftToRewards < ActiveRecord::Migration
  def change
  	add_column :rewards, :pledges_left, :integer
  end
end
