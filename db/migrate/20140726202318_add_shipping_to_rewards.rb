class AddShippingToRewards < ActiveRecord::Migration
  def change
  	add_column :rewards, :shipping, :boolean
  end
end
