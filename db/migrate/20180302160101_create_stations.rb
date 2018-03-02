class CreateStations < ActiveRecord::Migration[5.1]
  def change
    create_table :stations do |t|
      t.string :name
      t.float :latitude
      t.float :longitude
      t.float :distance_from_office
      t.string :address
      t.string :post_code

      t.timestamps
    end
  end
end
