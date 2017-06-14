# Weather Tracker

A Rails app that will track the weather conditions for a given set of zip codes. It was built following a Test-Driven Development approach.

## Libraries Used
- `whenever`
- `RestClient`
- `rspec-rails`
- `shoulda-matchers`

## Data Storage
Weather and location data is stored in a SQLite database since there is no need to separate data from the application and the database will not experience high-volume write activity.

### Tables
A zip_code identifies a location, which may have many weather measurements, as well as attributes like name, longitude, and latitude.
- locations
- weather_measurements

## Weather Retrieval
File: `lib/tasks/weather.rake`

A `rake` task retrieves and records the current weather for a given zip code. It makes a request for weather data to the OpenWeather API using the `RestClient` gem, then creates the necessary location and weather_measurement records in the database.

## Scheduling Retrieval
File: `config/schedule.rb`

The weather retrieval rake task is scheduled at frequencies defined in `config/application.rb`. Frequencies are defined for each zip code in a variable called `zip_codes`.

For example:
```
# frequency in minutes
config.zip_codes = {
      '06902' => 1,
      '11211' => 2
}
```

Scheduling is accomplished by creating cron jobs that are written to the crontab of the local Unix-based OS. Cron job configuration is facilitated by the `whenever` gem.

## Usage
### Setup
- `git clone https://github.com/Tassosb/weather-tracker.git`
- `cd weather-tracker`
- `bundle install`
- `bundle exec rake db:migrate`

### Testing
- `bundle exec rake spec`

### Schedule Retrieval
To schedule in development environment:
- `bundle exec whenever -w --set environment=development`

To schedule in production:
- `bundle exec whenever -w`

To see cron jobs:
- `crontab -l`

To clear all cron jobs:
- `crontab -r` or `whenever -c`

### Manual Weather Retrieval
- `bundle exec rake weather:retrieve_current[zip_code]`
