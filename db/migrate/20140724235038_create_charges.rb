class CreateCharges < ActiveRecord::Migration
  def change
    create_table :charges do |t|
      t.text :transaction

      t.timestamps
    end
  end
end
