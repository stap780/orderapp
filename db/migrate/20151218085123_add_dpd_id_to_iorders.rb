class AddDpdIdToIorders < ActiveRecord::Migration
  def change
  add_column :iorders, :dpd_id, :integer
  end
end
