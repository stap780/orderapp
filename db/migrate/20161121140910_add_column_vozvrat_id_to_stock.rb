class AddColumnVozvratIdToStock < ActiveRecord::Migration
  def change
  add_column :stocks, :vozvrat_id, :integer
  end
end
