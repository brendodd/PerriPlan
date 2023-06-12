class Restaurant < ApplicationRecord
  has_many :bookings, as: :bookable
  has_one_attached :photo
  geocoded_by :location
end
