class AddMycourierIdToIorders < ActiveRecord::Migration
  def change
  add_column :iorders, :mycourier_id, :integer
  end
end
