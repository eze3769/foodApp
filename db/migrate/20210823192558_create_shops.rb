class CreateShops < ActiveRecord::Migration[6.1]
  def change
    create_table :shops do |t|
      t.string :name
      t.string :nick
      t.string :category

      t.timestamps
    end
  end
end
