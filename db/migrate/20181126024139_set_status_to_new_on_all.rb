class SetStatusToNewOnAll < ActiveRecord::Migration[5.2]
  def change
    Listing.where('status is null').update_all(status: 0)
  end
end
