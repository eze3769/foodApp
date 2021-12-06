class AddToOrders < ActiveRecord::Migration[6.1]
  def change
    add_column :orders, :takenByKitchen, :datetime
    add_column :orders, :readyToServe, :datetime

  end
end
