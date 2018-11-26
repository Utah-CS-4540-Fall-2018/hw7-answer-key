class AddAgeToFamousSingers < ActiveRecord::Migration[5.2]
  def change
    add_column :famous_singers, :age, :integer
    add_column :famous_singers, :band_name, :string
  end
end
