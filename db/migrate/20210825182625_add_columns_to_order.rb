class AddColumnsToOrder < ActiveRecord::Migration[6.1]
  def change
    add_column :orders, :product, :string
    add_column :orders, :quantity, :float
    add_column :orders, :user, :string
    add_column :orders, :price, :float
  end
end
