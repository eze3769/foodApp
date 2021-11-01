class CreateCategories < ActiveRecord::Migration[6.1]
  def change
    create_table :categories do |t|
      t.string :name, null:false
      t.text :description
      t.references :shop, null: false, foreign_key: true

      t.timestamps
    end
  end
end
