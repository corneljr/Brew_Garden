class CreateUpdates < ActiveRecord::Migration
  def change
    create_table :updates do |t|
      t.string :title
      t.text :body
      t.integer :project_id

      t.timestamps
    end
  end
end
