require 'rake'

namespace :weather do
  desc "Retrieves and records current weather data"
  task :retrieve_current, [:zip_code] => [:environment] do |t, args|
    zip_code = args[:zip_code]
    Rails.logger.info "Retrieving weather for #{zip_code} at #{Time.current}"

    url = "http://api.openweathermap.org/data/2.5/weather?zip=" +
    zip_code + "&appid=#{ENV['OPEN_WEATHER_API_KEY']}"

    data = JSON.parse(RestClient.get(url))
    location = Location.get_record(zip_code, data)
    location.record_current_weather!(data)
  end
end
