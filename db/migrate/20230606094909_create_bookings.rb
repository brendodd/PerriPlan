class CreateBookings < ActiveRecord::Migration[7.0]
  def change
    create_table :bookings do |t|
      t.timestamp :start_time
      t.timestamp :end_time
      t.string :status
      t.string :note
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
