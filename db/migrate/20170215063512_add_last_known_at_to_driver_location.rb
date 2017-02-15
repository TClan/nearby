class AddLastKnownAtToDriverLocation < ActiveRecord::Migration
  def change
    add_column :driver_locations, :last_known_at, :datetime
  end
end
