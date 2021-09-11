class RemoveShopToOrders < ActiveRecord::Migration[6.1]
  def change
    remove_reference :orders, :shop,index:true, foreign_key: true
  end
end
