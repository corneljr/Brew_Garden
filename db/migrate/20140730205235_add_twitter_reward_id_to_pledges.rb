class AddTwitterRewardIdToPledges < ActiveRecord::Migration
  def change
  	add_column :pledges, :twitter_reward_id, :integer
  end
end
