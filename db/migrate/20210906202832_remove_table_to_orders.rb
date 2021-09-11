class RemoveTableToOrders < ActiveRecord::Migration[6.1]
  def change
    remove_reference :orders, :table,index:true, foreign_key: true
  end
end
