class Hotel < ApplicationRecord
  has_many :bookings, as: :bookable
 
end
