class AddColimnClientIdToIoders < ActiveRecord::Migration
  def change
    add_column :iorders, :client_id, :integer
  end
end
