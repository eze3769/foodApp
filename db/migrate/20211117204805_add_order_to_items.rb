class AddOrderToItems < ActiveRecord::Migration[6.1]
  def change
    add_reference :items, :orders, null: false, foreign_key: true
  end
end
