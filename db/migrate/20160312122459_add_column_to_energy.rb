class AddColumnToEnergy < ActiveRecord::Migration
  def change
  add_column :energies, :short_description, :string
  add_column :energies, :description, :string
  add_column :energies, :image_url, :string
  end
end
