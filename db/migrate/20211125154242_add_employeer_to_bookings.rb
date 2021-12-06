class AddEmployeerToBookings < ActiveRecord::Migration[6.1]
  def change
    add_reference :bookings, :employeer,  foreign_key: true
  end
end
