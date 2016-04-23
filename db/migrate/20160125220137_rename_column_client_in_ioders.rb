class RenameColumnClientInIoders < ActiveRecord::Migration
  def change
  	rename_column :iorders, :client, :clientname
  end
end
