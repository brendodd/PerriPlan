class Hotel < ApplicationRecord
  has_many :bookings, as: :bookable
  geocoded_by :location
  # after_validation :geocode, if: :will_save_change_to_address?
  serialize :image_url, JSON
end
