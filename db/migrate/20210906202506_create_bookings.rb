class CreateBookings < ActiveRecord::Migration[6.1]
  def change
    create_table :bookings do |t|
      t.references :table, null: false, foreign_key: true
      t.string :status
      t.float :total
      t.string :user
      t.integer :phone
      t.string :address
      t.string :email

      t.timestamps
    end
  end
end
