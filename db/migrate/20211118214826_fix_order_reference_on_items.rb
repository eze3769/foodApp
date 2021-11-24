class FixOrderReferenceOnItems < ActiveRecord::Migration[6.1]
  def change
    remove_reference :items, :orders, index:true, foreign_key: true
    add_reference :items, :order, null: false, foreign_key: true
  end
end
