class AddCounterFieldToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :listings, :last_time_on_the_moon, :timestamp
  end
end
