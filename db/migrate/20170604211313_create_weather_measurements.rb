class CreateWeatherMeasurements < ActiveRecord::Migration[5.0]
  def change
    create_table :weather_measurements do |t|
      t.integer :location_id, null: false, index: true
      t.string :condition
      t.integer :pressure
      t.integer :temperature
      t.integer :humidity
      t.integer :wind_speed
      t.integer :wind_direction

      t.timestamps
    end
  end
end
