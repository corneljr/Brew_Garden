class AddFundedAmountToProjects < ActiveRecord::Migration
  def change
  	add_column :projects, :funded_amount, :integer
  end
end
