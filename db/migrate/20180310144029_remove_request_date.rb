class RemoveRequestDate < ActiveRecord::Migration[5.1]
  def change
    drop_table :request_dates
  end
end
