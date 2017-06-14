require 'rails_helper'

RSpec.describe WeatherMeasurement, type: :model do
  it { should validate_presence_of(:location) }

  it { should belong_to(:location) }
end
