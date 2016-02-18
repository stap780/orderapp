class AddCourierIdToIorders < ActiveRecord::Migration
  def change
  add_column :iorders, :courier_id, :integer
  end
end
