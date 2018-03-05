class CreateRequestDates < ActiveRecord::Migration[5.1]
  def change
    create_table :request_dates do |t|
      t.string :request_name
      t.datetime :date

      t.timestamps
    end
  end
end
