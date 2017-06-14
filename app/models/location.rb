class Location < ApplicationRecord
  validates :zip_code, presence: true

  has_many :weather_measurements, dependent: :destroy

  def self.get_record(zip_code, data)
    parsed_data = self.location_data(data)

    Location.create_with(parsed_data)
            .find_or_create_by!(zip_code: zip_code)
  end

  def self.location_data(data)
    {
      latitude: data["coord"]["lat"],
      longitude: data["coord"]["lon"],
      name: data["name"]
    }
  end

  def self.temp_in_fahrenheit(temp)
    (temp.to_f - 273) * 9/5 + 32
  end

  def record_current_weather!(data)
    temp = Location.temp_in_fahrenheit(data["main"]["temp"])

    self.weather_measurements.create!({
      condition: data["weather"][0]["main"],
      pressure: data["main"]["pressure"],
      temperature: temp,
      humidity: data["main"]["humidity"],
      wind_speed: data["wind"]["speed"],
      wind_direction: data["wind"]["deg"]
    })
  end
end
