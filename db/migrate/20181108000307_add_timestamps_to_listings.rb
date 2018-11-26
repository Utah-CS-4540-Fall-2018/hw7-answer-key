class AddTimestampsToListings < ActiveRecord::Migration[5.2]
  def change
    add_column :listings, :walks_like_a_duck, :boolean, default: false
  end
end
