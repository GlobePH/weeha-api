class Location < ApplicationRecord
  belongs_to :user

  validates :lat, :lng, presence: true
end
