class AddShopToOrders < ActiveRecord::Migration[6.1]
  def change
    add_reference :orders, :shop, null: false, foreign_key: true
  end
end
