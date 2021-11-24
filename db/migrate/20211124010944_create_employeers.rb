class CreateEmployeers < ActiveRecord::Migration[6.1]
  def change
    create_table :employeers do |t|
      t.string :name, null:false
      t.string :lastName, null:false
      t.integer :identification
      t.integer :phone
      t.references :shop, null: false, foreign_key: true
      t.integer :shift

      t.timestamps
    end
  end
end
