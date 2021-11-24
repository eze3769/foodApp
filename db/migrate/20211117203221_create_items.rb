class CreateItems < ActiveRecord::Migration[6.1]
  def change
    create_table :items do |t|
      t.text :observations
      t.integer :quantity
      t.references :shop, null: false, foreign_key: true
      t.references :product, null: false, foreign_key: true
      t.timestamps
    end
  end
end
