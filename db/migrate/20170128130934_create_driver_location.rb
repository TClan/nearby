class CreateDriverLocation < ActiveRecord::Migration
  def change
    create_table :driver_locations do |t|
      t.integer :driver_id
      t.st_point :latlong, geographic: true
      t.decimal :accuracy
      t.timestamps
      t.index :latlong, using: :gist
      t.index :driver_id
    end
  end
end
