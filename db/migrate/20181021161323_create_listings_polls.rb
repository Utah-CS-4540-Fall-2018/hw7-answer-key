class CreateListingsPolls < ActiveRecord::Migration[5.2]
  def change
    create_table :listings_polls do |t|
      t.boolean :is_automated
      t.timestamp :started_at
      t.timestamp :finished_at
      t.text :notes

      t.timestamps
    end
  end
end
