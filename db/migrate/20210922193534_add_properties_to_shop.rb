class AddPropertiesToShop < ActiveRecord::Migration[6.1]
  def change
    add_column :shops, :email, :string
    add_column :shops, :address, :string
    add_column :shops, :country, :string
    add_column :shops, :state, :string
    add_column :shops, :city, :string

  
  end
end
