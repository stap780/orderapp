class AddStatusnumberToImls < ActiveRecord::Migration
  def change
  add_column :imls, :statenum, :integer
  add_column :imls, :statusnum, :integer
  end
end
