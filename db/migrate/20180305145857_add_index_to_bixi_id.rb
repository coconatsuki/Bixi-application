class AddIndexToBixiId < ActiveRecord::Migration[5.1]
  def change
    add_index :stations, :bixi_id
  end
end
