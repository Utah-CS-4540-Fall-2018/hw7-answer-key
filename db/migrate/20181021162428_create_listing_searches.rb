class CreateListingSearches < ActiveRecord::Migration[5.2]
  def change
    create_table :listing_searches do |t|
      t.references :search, foreign_key: true
      t.references :listing, foreign_key: true

      t.timestamps
    end
  end
end
