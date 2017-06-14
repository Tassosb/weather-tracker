require 'rails_helper'
require 'rake'

describe 'weather rake tasks' do
  before :all do
    Rake.application.rake_require "tasks/weather"
    Rake::Task.define_task(:environment)
  end

  describe ':retrieve_current' do
    let(:location) do
      double("Location instance", :record_current_weather! => true)
    end

    before do
      # allow(Location).to receive(:create_with).and_return(Location)
      allow(Location).to receive(:get_record).and_return(location)
    end

    let :run_rake_task do
      Rake::Task["weather:retrieve_current"].reenable
      Rake::Task["weather:retrieve_current"].invoke('06902')
    end

    it "should find or create a location" do
      expect(Location).to receive(:get_record)
      run_rake_task
    end

    it "should record the current weather for matching location" do
      expect(location).to receive(:record_current_weather!)
      run_rake_task
    end
  end
end
