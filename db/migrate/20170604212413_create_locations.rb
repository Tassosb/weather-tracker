class CreateLocations < ActiveRecord::Migration[5.0]
  def change
    create_table :locations do |t|
      t.string :zip_code, null: false, index: true
      t.integer :latitude
      t.integer :longitude
      t.string :name

      t.timestamps
    end
  end
end
