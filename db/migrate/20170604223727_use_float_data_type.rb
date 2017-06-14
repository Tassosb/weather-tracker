class UseFloatDataType < ActiveRecord::Migration[5.0]
  def change
    change_column :locations, :latitude, :float
    change_column :locations, :longitude, :float

    cols = %W{pressure temperature humidity wind_speed wind_direction}

    cols.each do |c|
      change_column :weather_measurements, c, :float
    end
  end
end
