class AddNumberToMycouriers < ActiveRecord::Migration
  def change
  add_column :mycouriers, :number, :integer
  end
end
