class AddColumnCidToCitilinks < ActiveRecord::Migration
  def change
    add_column :citilinks, :cid, :string
  end
end
