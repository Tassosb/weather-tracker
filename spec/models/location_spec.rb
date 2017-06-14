require 'rails_helper'

RSpec.describe Location, type: :model do
  it { should validate_presence_of(:zip_code) }
  it { should have_many(:weather_measurements) }

  before :all do
    Location.create!(zip_code: '123456')
  end

  describe '::get_record' do
    let(:data) do
      {'coord' => {'lat' => 82.8, 'lon' => 135.00}, 'name' => "Antarctica"}
    end

    context 'when finding a matching location' do
      it 'returns the correct location' do
        found = Location.get_record('123456', data)
        expect(found).to be_instance_of(Location)
        expect(found.zip_code).to eq('123456')
      end

      it 'does not create a location record if a matching location exists' do
        [:new, :create!, :create].each do |method|
          expect(Location).not_to receive(method)
        end

        Location.get_record('123456', data)
      end
    end

    context 'when creating a new location' do
      it 'creates a location record if one does not exist' do
        created = Location.get_record('654321', data)
        expect(created).to be_instance_of(Location)
        expect(created).to be_persisted
        expect(created.zip_code).to eq('654321')
      end
    end
  end

  describe '#record_current_weather!' do
    let(:data) do
      {
        'weather' => [{'main' => 'Rainy'}],
        'main' => {
          'pressure' => 1,
          'temp' => 80,
          'humidity' => 71,
          },
        'wind' => {
          'speed' => 50,
          'deg' => 20.3
        }
      }
    end

    let(:location) { Location.create!(zip_code: '111111') }

    it 'creates a correctly associated weather measuerement record' do
      expect(location.weather_measurements).to be_empty
      location.record_current_weather!(data)
      expect(location.weather_measurements.count).to eq(1)
    end

    it 'converts temperature to Fahrenheit before saving' do
      new_weather = location.record_current_weather!(data)
      temp_in_fahrenheit = (80.0 - 273) * 9/5 + 32
      expect(new_weather.temperature).to be_within(0.5).of(temp_in_fahrenheit)
    end
  end
end
