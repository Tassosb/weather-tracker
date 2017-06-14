class WeatherMeasurement < ApplicationRecord
  validates :location, presence: true

  belongs_to :location
end
