class Station < ApplicationRecord
  reverse_geocoded_by :latitude, :longitude
  after_validation :reverse_geocode

  validates :bixi_id, presence: true
  validates :longitude, presence: true
  validates :latitude, presence: true
end
