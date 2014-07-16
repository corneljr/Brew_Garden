class AddDefaultValueToFundedAmountInProjects < ActiveRecord::Migration
  def change
  	change_column :projects, :funded_amount, :integer, default: 0
  end
end
