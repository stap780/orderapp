class RemoveColumnAndAddColumn < ActiveRecord::Migration
  def up
    remove_column :clients, :company_id
  end

  def down
    add_column :ioders, :client_id, :integer
  end
end
