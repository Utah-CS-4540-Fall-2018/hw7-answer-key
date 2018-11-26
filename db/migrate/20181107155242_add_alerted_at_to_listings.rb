class AddAlertedAtToListings < ActiveRecord::Migration[5.2]
  def change
    add_column :listings, :alerted_at, :timestamp
    add_column :listings, :reviewed_at, :timestamp
  end
end
