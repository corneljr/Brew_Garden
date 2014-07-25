class ChangeTransactionToRewardTransactionInCharges < ActiveRecord::Migration
  def change
  	remove_column :charges, :transaction, :text
  	add_column :charges, :pledge_transaction, :text
  end
end
