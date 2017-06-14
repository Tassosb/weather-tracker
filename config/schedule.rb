# Learn more: http://github.com/javan/whenever

require File.expand_path(File.dirname(__FILE__) + "/environment")

Rails.configuration.zip_codes.each do |zip_code, freq|
  every freq.minutes do
    rake "weather:retrieve_current[#{zip_code}]"
  end
end
