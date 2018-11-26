class CreateFamousSingers < ActiveRecord::Migration[5.2]
  def change
    create_table :famous_singers do |t|
      t.string :name
      t.float :range_in_octives
    end
  end
end
