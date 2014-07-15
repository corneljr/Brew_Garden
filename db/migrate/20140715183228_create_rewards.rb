class CreateRewards < ActiveRecord::Migration
  def change
    create_table :rewards do |t|
      t.integer :project_id
      t.integer :amount
      t.string :description

      t.timestamps
    end
  end
end
