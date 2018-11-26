class CreateListings < ActiveRecord::Migration[5.2]
  def change
    create_table :listings do |t|
      t.string :url
      t.string :title
      t.text :description
      t.string :pricing
      t.references :listings_poll, foreign_key: true

      t.timestamps
    end
  end
end
