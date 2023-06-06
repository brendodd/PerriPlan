class Restaurant < ApplicationRecord
  has_many :bookings, as: :bookable
end
