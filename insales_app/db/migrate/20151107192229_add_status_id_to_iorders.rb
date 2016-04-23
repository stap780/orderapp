class AddStatusIdToIorders < ActiveRecord::Migration
  def change
  add_column :iorders, :status_id, :integer
  end
end
