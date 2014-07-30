class CreateTwitterRewards < ActiveRecord::Migration
  def change
    create_table :twitter_rewards do |t|
      t.integer :project_id
      t.string :message
      t.string :hashtags

      t.timestamps
    end
  end
end
