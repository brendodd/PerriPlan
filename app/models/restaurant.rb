class Restaurant < ApplicationRecord
  has_many :bookings, as: :bookable
  has_many :reviews, through: :bookings
  has_one_attached :photo
  geocoded_by :location
  after_validation :geocode # ,if: :will_save_change_to_address?
  acts_as_favoritable
end
