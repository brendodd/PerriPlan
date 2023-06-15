class Attraction < ApplicationRecord
  geocoded_by :location
  has_one_attached :photo
  acts_as_favoritable
end
