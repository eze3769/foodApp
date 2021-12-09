class ChangeIntegerLimitInBookings < ActiveRecord::Migration[6.1]
  def change
    change_column :bookings, :phone, :integer, limit: 8
    add_column :bookings, :dni, :integer, limit: 8
  end
end
