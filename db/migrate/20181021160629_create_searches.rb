class CreateSearches < ActiveRecord::Migration[5.2]
  def change
    create_table :searches do |t|
      t.references :user, foreign_key: true
      t.string :keywords

      t.timestamps
    end
  end
end
