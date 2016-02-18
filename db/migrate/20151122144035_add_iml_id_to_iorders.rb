class AddImlIdToIorders < ActiveRecord::Migration
  def change
  add_column :iorders, :iml_id, :integer
  end
end
