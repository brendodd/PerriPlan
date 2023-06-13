class Restaurant < ApplicationRecord
  has_many :bookings, as: :bookable
  has_one_attached :photo
  geocoded_by :location
restaurants_geocoding
  after_validation :geocode # ,if: :will_save_change_to_address?
end
