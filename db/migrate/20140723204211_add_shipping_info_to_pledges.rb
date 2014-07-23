class AddShippingInfoToPledges < ActiveRecord::Migration
  def change
    add_column :pledges, :address, :string
    add_column :pledges, :postal_code, :string
    add_column :pledges, :city, :string
    add_column :pledges, :province, :string
  end
end
