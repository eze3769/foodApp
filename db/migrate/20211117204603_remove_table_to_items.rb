class RemoveTableToItems < ActiveRecord::Migration[6.1]
  def change
    remove_reference :items, :shop, index:true, foreign_key: true
  end
end
