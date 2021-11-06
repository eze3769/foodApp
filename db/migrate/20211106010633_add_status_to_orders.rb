class AddStatusToOrders < ActiveRecord::Migration[6.1]
  def change
    add_column :orders, :status, :string
    add_column :orders, :timeToServe, :datetime, default: "pending"
  end
end
