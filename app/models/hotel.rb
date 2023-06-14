class Hotel < ApplicationRecord
  acts_as_taggable_on :tags
  has_many :bookings, as: :bookable
  has_many :reviews, through: :bookings
  geocoded_by :location
  # after_validation :geocode, if: :will_save_change_to_address?
  serialize :image_url, JSON
end
