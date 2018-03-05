class AddAvailableBixisToStation < ActiveRecord::Migration[5.1]
  def change
        add_column :stations, :available_bixis, :integer
  end
end
