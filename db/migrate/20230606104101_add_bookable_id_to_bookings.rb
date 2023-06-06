class AddBookableIdToBookings < ActiveRecord::Migration[7.0]
  def change
    add_reference :bookings, :bookable, polymorphic: true, null: false
  end
end
