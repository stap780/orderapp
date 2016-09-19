class AddColumnMiddelNameToUsers < ActiveRecord::Migration
  def change
    add_column :users, :middel_name, :sting
  end
end
